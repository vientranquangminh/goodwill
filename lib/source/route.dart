import 'package:flutter/material.dart';
import 'package:goodwill/source/ui/components/page_controller.dart';
import 'package:goodwill/source/ui/page/post.dart';
import 'package:goodwill/source/ui/page/profile.dart';

// class CommonRoutes {
//   static const startApp = '/';
//   // static const home = '/home';
//   static const signIn = '/sign_in';
//   static const signUp = '/sign_up';
// }

class Route {
  static const pageController = '/';
  static const post = '/post';
  static const profile = '/profile';
}

var customRoutes = <String, WidgetBuilder>{
  Route.pageController: (context) => const MyPageController(),
  Route.post: (context) => const Post(),
  Route.profile: (context) => const Profile()
};
