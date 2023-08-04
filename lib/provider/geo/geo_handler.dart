import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeoHandler {
  static Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  static List<Placemark>? placeMarks;
  static Future<List<Placemark>?> onGetPlaceMarker({
    required double lat,
    required double long,
  }) async {
    return placeMarks = await placemarkFromCoordinates(lat, long).then((value) {
    });
  }

  static Future<void> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      onGetPlaceMarker(lat: position.latitude, long: position.longitude);
      // getAddressFromLatLng(position);
      print(
          "position ${position.latitude}, ${position.longitude} ${position}, ${position.accuracy}");
    }).catchError((e) {
      debugPrint(e);
    });
  }

  // static Future<void> getAddressFromLatLng(Position position) async {
  //   await placemarkFromCoordinates(position.latitude, position.longitude)
  //       .then((placeMarks) {
  //     Placemark place = placeMarks[0];
  //     print("place $place");
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }

  String? _currentAddress;
  Position? _currentPosition;

  GeoHandler._();
}
