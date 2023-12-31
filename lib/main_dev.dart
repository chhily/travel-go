import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:travel_go/base/exception_handler.dart';
import 'package:travel_go/config/flavor.dart';

import 'main.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlavorConfig(flavor: Flavor.dev, values: FlavorValues(appName: "DEV"));
  BaseHttpClient.init();
  runApp(const MyApp());
  // GeoHandler().handleLocationPermission();
  FlutterNativeSplash.remove();
}


