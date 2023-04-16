import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goodwill/source/service/auth_service.dart';
import 'package:goodwill/source/ui/page/home/home_page.dart';
import 'package:goodwill/source/ui/page/sign_in/sign_in.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    var _stream = AuthService.authChanges;

    return StreamBuilder<User?>(
      stream: _stream,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return const HomePage();
        } else {
          return const SignInScreen();
        }
      },
    );
  }
}
