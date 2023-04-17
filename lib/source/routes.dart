import 'package:flutter/material.dart';
import 'package:goodwill/source/ui/components/page_controller.dart';
import 'package:goodwill/source/ui/page/chat/chat_screen.dart';
import 'package:goodwill/source/ui/page/post.dart';
import 'package:goodwill/source/ui/page/product/category_page.dart';
import 'package:goodwill/source/ui/page/product/product_details_page.dart';
import 'package:goodwill/source/ui/start_app.dart';
import 'package:goodwill/source/ui/page/chat/room_chat_screen.dart';

class Routes {
  static const startApp = '/';
  static const myPageController = '/my-page-controller';
  static const post = '/post';
  static const profile = '/profile';
  static const category = '/category';
  static const productDetails = '/product-details';
  static const chatScreen = '/chat-screen';
  static const roomChatScreen = '/room-chat';
}

var customRoutes = <String, WidgetBuilder>{
  Routes.startApp: (context) => const StartApp(),
  Routes.myPageController: (context) => const MyPageController(),
  Routes.category: (context) => const CategoryPage(),
  Routes.post: (context) => const Post(),
  Routes.productDetails: (context) => const ProductDetailsPage(),
  Routes.roomChatScreen: (context) => const RoomChatScreen(),
  Routes.chatScreen: (context) => const ChatScreen()
};
