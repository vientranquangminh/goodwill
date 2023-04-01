import 'package:flutter/material.dart';
import 'package:goodwill/source/app.dart';
import 'package:goodwill/source/injection/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependenciesInjection();
  runApp(const App());
}
