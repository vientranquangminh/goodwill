import 'package:flutter/material.dart';
import 'package:goodwill/source/ui/components/page_controller.dart';
import 'package:goodwill/source/ui/page/post.dart';
import 'package:goodwill/source/ui/page/product/category_page.dart';
import 'package:goodwill/source/ui/page/product/product_details_page.dart';
import 'package:goodwill/source/ui/start_app.dart';

class Routes {
  static const startApp = '/';
  static const myPageController = '/my-page-controller';
  static const post = '/post';
  static const profile = '/profile';
  static const category = '/category';
  static const productDetails = '/product-details';
}

var customRoutes = <String, WidgetBuilder>{
  Routes.startApp: (context) => const StartApp(),
  Routes.myPageController: (context) => const MyPageController(),
  Routes.category:(context) => const CategoryPage(),
  Routes.post: (context) => const Post(),
  Routes.productDetails: (context) => const ProductDetailsPage(),
};
