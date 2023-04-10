import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:goodwill/source/service/auth_service.dart';
import 'package:goodwill/source/ui/page/home/home_page.dart';
import 'package:goodwill/source/ui/page/sign_in/sign_in.dart';
import 'package:goodwill/source/ui/page/sign_in/sign_up.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    var _instance = FirebaseAuth.instance;
    _instance.authStateChanges().listen((User? user) {});
    return StreamBuilder<User?>(
      stream: AuthService.user,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return SignInScreen();
        }
      },
    );
  }
}
