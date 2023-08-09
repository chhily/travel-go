import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:travel_go/base/exception_handler.dart';
import 'package:travel_go/base/server_exception.dart';
import 'package:travel_go/constant/error_message.dart';

class BaseApiService {
  late Dio dio;
  BaseApiService({Dio? dio}) {
    if (dio != null) {
      this.dio = dio;
    } else {
      this.dio = BaseHttpClient.dio;
    }
  }
  static const String messageField = "message";

  Future<T> onRequest<T>({
    required String path,
    required String method,
    required T Function(Response response) onSuccess,
    Map<String, dynamic>? query,
    Map<String, dynamic> headers = const {},
    dynamic data = const {},
    bool requiredToken = true,
    String? customToken,
    Dio? customDioClient,
    bool autoRefreshToken = true,
  }) async {
    late Response response;

    try {
      final httpOption = Options(method: method, headers: {});

      if (customToken != null) {
        httpOption.headers!['Authorization'] = "bearer $customToken";
      }
      httpOption.headers!.addAll(headers);
      query ??= {};
      if (customDioClient != null) {
        response = await customDioClient.request(
          path,
          options: httpOption,
          queryParameters: query,
          data: data,
        );
      } else {
        response = await dio.request(
          path,
          options: httpOption,
          queryParameters: query,
          data: data,
        );
      }
      if (response.data != null) {
        debugPrint("res:${response.statusCode}");
        return onSuccess(response);
      } else {
        throw ServerResponseException(response.data[messageField]);
      }
    } on DioException catch (exception) {
      throw _onDioError(exception);
    } on ServerResponseException catch (exception) {
      throw _onServerResponseException(exception, response);
    } catch (exception) {
      throw _onTypeError(exception);
    }
  }
}

String _onTypeError(dynamic exception) {
  ///Logic or syntax error on some condition
  debugPrint(
      "Type Error :=> ${exception.toString()}\nStackTrace:  ${exception.stackTrace.toString()}");
  return ErrorMessage.SOMETHING_WRONG;
}

//
DioErrorException _onDioError(DioException exception) {
  _logDioError(exception);
  if (exception.error is SocketException) {
    ///Socket exception mostly from internet connection or host
    return DioErrorException(ErrorMessage.CONNECTION_ERROR);
  } else if (exception.type == DioExceptionType.connectionTimeout) {
    ///Connection timeout due to internet connection or server not responding
    return DioErrorException(ErrorMessage.TIMEOUT_ERROR);
  } else if (exception.type == DioExceptionType.badResponse) {
    ///Error that range from 400-500
    String serverMessage;
    if (exception.response!.data is Map) {
      serverMessage =
          exception.response?.data["message"] ?? ErrorMessage.UNEXPECTED_ERROR;
    } else {
      serverMessage = ErrorMessage.UNEXPECTED_ERROR;
    }
    return DioErrorException(serverMessage,
        code: exception.response!.statusCode);
  }
  throw DioErrorException(ErrorMessage.UNEXPECTED_ERROR);
}

ServerResponseException _onServerResponseException(
    dynamic exception, Response response) {
  debugPrint(
      "Http Log: Server error :=> ${response.requestOptions.path}:=> $exception");
  //httpLog("Server error :=> ${response.requestOptions.path}:=> $exception");
  return ServerResponseException(exception.toString());
}

void _logDioError(DioException exception) {
  String errorMessage = "Dio error :=> ${exception.requestOptions.path}";
  if (exception.response != null) {
    errorMessage += ", Response: => ${exception.response!.data.toString()}";
  } else {
    errorMessage += ", ${exception.message}";
  }

  debugPrint("Http Log: Server error test :=> $errorMessage");
}

String handleExceptionError(dynamic error, [String path = ""]) {
  debugPrint(
      "Exception caught [${error.runtimeType}][$path]: ${error.toString()}");
  String errorMessage = ErrorMessage.UNEXPECTED_ERROR;
  //Dio Error
  if (error is DioException) {
    if (error.error is SocketException) {
      errorMessage = ErrorMessage.CONNECTION_ERROR;
    } else if (error.type == DioExceptionType.connectionTimeout) {
      errorMessage = ErrorMessage.TIMEOUT_ERROR;
    } else if (error.type == DioExceptionType.badResponse) {
      debugPrint("Dio Response error on: ${error.requestOptions.path}");
      if (error.response!.statusCode == 502) {
        errorMessage =
            "${error.response!.statusCode}: ${ErrorMessage.SERVER_ERROR}";
      } else {
        errorMessage =
            "${error.response!.statusCode}: ${ErrorMessage.UNEXPECTED_ERROR}";
      }
    }
    return errorMessage;
    //Json convert error
  } else if (error is TypeError) {
    debugPrint(error.stackTrace.toString());
    return errorMessage;
    //Error message from server
  } else if (error is ArgumentError) {
    throw errorMessage;
  } else {
    return error.toString();
  }
}
