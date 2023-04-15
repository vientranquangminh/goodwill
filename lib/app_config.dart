import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/firebase_options.dart';
import 'package:goodwill/source/injection/injector.dart';

class AppConfiguration {
  AppConfiguration._();

  static const mainAppSize = Size(375, 812);

  static const maxUsernameLength = 15;

  static RegExp usernamePattern = RegExp(r'^[a-zA-Z\d_\-=@.]+$');

  static Future<void> ensureAppConfiguration() async {
    await ScreenUtil.ensureScreenSize();
    // await initDependenciesInjection();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  }
}
