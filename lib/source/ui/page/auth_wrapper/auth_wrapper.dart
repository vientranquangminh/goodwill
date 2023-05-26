import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goodwill/source/service/auth_service.dart';
import 'package:goodwill/source/ui/components/page_controller.dart';
import 'package:goodwill/source/ui/page/sign_in/sign_in.dart';
import 'package:goodwill/source/ui/page/sign_in/sign_up.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    var _stream = AuthService.authChanges;

    return StreamBuilder<User?>(
      stream: _stream,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return const MyPageController();
        } else {
          return const SignInScreen();
        }
      },
    );
  }
}
