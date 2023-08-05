import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:travel_go/config/flavor.dart';
import 'package:travel_go/provider/geo/geo_handler.dart';

import 'main.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlavorConfig(flavor: Flavor.dev, values: FlavorValues(appName: "DEV"));
  runApp(const MyApp());
  GeoHandler().handleLocationPermission();
  FlutterNativeSplash.remove();
}


