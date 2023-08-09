import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:travel_go/constant/app_url.dart';

class BaseHttpClient {
  static late final Dio dio;

  static void init() {
    final BaseOptions options = BaseOptions(
      baseUrl: AppUrl.baseApi,
      connectTimeout: const Duration(milliseconds: 50000),
      receiveTimeout: const Duration(milliseconds: 50000),
    );

    dio = Dio()
      ..options = options
      ..interceptors.add(defaultInterceptor);
  }
}

const JsonDecoder decoder = JsonDecoder();
const JsonEncoder encoder = JsonEncoder.withIndent('  ');

final InterceptorsWrapper defaultInterceptor = InterceptorsWrapper(
  onRequest: (RequestOptions options,
      RequestInterceptorHandler requestInterceptorHandler) async {
    httpLog("${options.method}: ${options.path},"
        "query: ${options.queryParameters},"
        "data: ${options.data},");
    //"token: ${ObjectUtils.getLastIndexString(options.headers["authorization"])}");
    requestInterceptorHandler.next(options);
  },
  onResponse: (Response response,
      ResponseInterceptorHandler responseInterceptorHandler) async {
    prettyPrintJson(response.data);
    responseInterceptorHandler.next(response);
  },
  onError: (DioException error,
      ErrorInterceptorHandler errorInterceptorHandler) async {
    errorInterceptorHandler.reject(error);
  },
);

void httpLog([dynamic log, dynamic additional = ""]) {
  if (kDebugMode) debugPrint("Http request Log: $log $additional");
}

void prettyPrintJson(dynamic input) {
  var prettyString = encoder.convert(input);
  prettyString.split('\n').forEach((element) => debugPrint(element));
}
