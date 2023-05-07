import 'package:flutter/material.dart';
import 'package:goodwill/source/ui/admin/login_screen.dart';
import 'package:goodwill/source/ui/components/page_controller.dart';
import 'package:goodwill/source/ui/page/cart_product/cart_product.dart';
import 'package:goodwill/source/ui/page/category/category_page.dart';
import 'package:goodwill/source/ui/page/chat/chat_screen.dart';
import 'package:goodwill/source/ui/page/post/post.dart';
import 'package:goodwill/source/ui/page/product/product_details_page.dart';
import 'package:goodwill/source/ui/page/profile.dart';
import 'package:goodwill/source/ui/page/profile/change_language/change_language_page.dart';
import 'package:goodwill/source/ui/page/profile/edit_profile.dart';
import 'package:goodwill/source/ui/page/profile/notification_screen.dart';
import 'package:goodwill/source/ui/page/profile/security_screen.dart';
import 'package:goodwill/source/ui/page/sign_in/fill_profile.dart';
import 'package:goodwill/source/ui/page/sign_in/sign_in.dart';
import 'package:goodwill/source/ui/page/sign_in/sign_up.dart';
import 'package:goodwill/source/ui/start_app.dart';
import 'package:goodwill/source/ui/page/chat/room_chat_screen.dart';

import 'ui/page/article/create_topic/create_topic.dart';
import 'ui/page/search/search_product.dart';

class Routes {
  static const startApp = '/';
  static const signIn = '/sign_in';
  static const signUp = '/sign_Up';
  static const fillProfile = '/fillProfile';
  static const myPageController = '/pageController';
  static const post = '/post';
  static const profile = '/profile';
  static const category = '/category';
  static const productDetails = '/product-details';
  static const chatScreen = '/chat-screen';
  static const roomChatScreen = '/room-chat';
  static const searchScreen = '/search-screen';
  static const editProfile = '/edit-profile';
  static const notification = '/notification';
  static const security = '/security';
  static const cartProduct = '/cart-product';
  static const adminLogin = '/admin-login-page';
  static const createTopic = '/create-topic';

  static pushNamed() {}
  static const changeLanguage = '/change-language';
}

var customRoutes = <String, WidgetBuilder>{
  Routes.signIn: (context) => const SignInScreen(),
  Routes.signUp: (context) => const SignUpScreen(),
  Routes.fillProfile: (context) => const FillProfileScreen(),
  Routes.post: (context) => const Post(),
  Routes.profile: (context) => const Profile(),
  Routes.startApp: (context) => const StartApp(),
  Routes.myPageController: (context) => const MyPageController(),
  Routes.category: (context) => const CategoryPage(),
  Routes.productDetails: (context) => const ProductDetailsPage(),
  Routes.roomChatScreen: (context) => const RoomChatScreen(),
  Routes.chatScreen: (context) => const ChatScreen(),
  Routes.searchScreen: (context) => const SearchScreen(),
  Routes.editProfile: (context) => const EditProfilePage(),
  Routes.notification: (context) => const NotificationPage(),
  Routes.security: (context) => const SecurityPage(),
  Routes.changeLanguage: (context) => const ChangePasswordPage(),
  Routes.cartProduct: (context) => const CartProduct(),
  Routes.adminLogin: (context) => const LoginAdminScreen(),
  Routes.createTopic: (context) => const CreateTopic()
};
