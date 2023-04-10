import 'package:flutter/material.dart';
import 'package:goodwill/app_config.dart';
import 'package:goodwill/source/app.dart';

void main() async {
  // Make sure Firebase has been initialized be4 run App
  await AppConfiguration.ensureAppConfiguration();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}
