import 'package:flutter/material.dart';
import 'package:travel_go/config/flavor.dart';

import 'main.dart';

void main() {
  FlavorConfig(flavor: Flavor.dev, values: FlavorValues(appName: "DEV"));
  runApp(const MyApp());
}
