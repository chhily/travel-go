import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeoHandler {
  String? currentAddress;
  var myAddressController = StreamController<String?>.broadcast();

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  void onGetUserLocation() async {
    final positionValue = await onGetCurrentPosition();
    if (positionValue == null) return;
    final addressValue = await onGetPlaceMarker(
        lat: positionValue.latitude, long: positionValue.longitude);
    if (addressValue == null) return;
    for (int i = 0; i < addressValue.length; i++) {
      currentAddress = addressValue[0].administrativeArea ?? "N/A";
      myAddressController.add(currentAddress);
    }
  }

  List<Placemark>? placeMarks;
  Future<List<Placemark>?> onGetPlaceMarker({
    required double lat,
    required double long,
  }) async {
    return placeMarks = await placemarkFromCoordinates(lat, long);
  }

  Future<Position?> onGetCurrentPosition() async {
    final positionValue = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      return position;
    }).catchError((e) {
      debugPrint(e);
      return e;
    });
    return positionValue;
  }
}
