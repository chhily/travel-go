import 'package:flutter/material.dart';
import 'package:travel_go/config/flavor.dart';
import 'package:travel_go/main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(
      flavor: Flavor.production, values: FlavorValues(appName: "Production"));
  runApp(const MyApp());
}
