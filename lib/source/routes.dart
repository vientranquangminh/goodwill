import 'package:flutter/material.dart';
import 'package:goodwill/source/ui/page/profile.dart';
import 'package:goodwill/source/ui/page/sign_in/fill_profile.dart';
import 'package:goodwill/source/ui/page/sign_in/sign_in.dart';
import 'package:goodwill/source/ui/start_app.dart';

import 'ui/components/page_controller.dart';
import 'ui/page/post.dart';

class Routes {
  static const startApp = '/';
  static const signIn = '/sign_in';
  static const fillProfile = '/fillProfile';
  static const pageController = '/pageController';
  static const post = '/post';
  static const profile = '/profile';
}

var customRoutes = <String, WidgetBuilder>{
  Routes.signIn: (context) => const SignInScreen(),
  Routes.fillProfile: (context) => const FillProfileScreen(),
  Routes.pageController: (context) => const MyPageController(),
  Routes.post: (context) => const Post(),
  Routes.profile: (context) => const Profile()
};
