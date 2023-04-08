import 'package:flutter/material.dart';
import 'package:goodwill/app_config.dart';
import 'package:goodwill/source/app.dart';

void main() async {
  AppConfiguration.ensureAppConfiguration();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}
