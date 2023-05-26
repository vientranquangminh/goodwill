import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/routes.dart';

class WaitingVerifyScreen extends StatefulWidget {
  const WaitingVerifyScreen({Key? key}) : super(key: key);

  @override
  State<WaitingVerifyScreen> createState() => _WaitingVerifyScreenState();
}

class _WaitingVerifyScreenState extends State<WaitingVerifyScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/sign_in/zyro-image.png'),
            Text(
              context.localizations.verifyEmail,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            const SizedBox(height: 15),
            Text(
              context.localizations.notBeenVerified +
                  context.localizations.importantNotification,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    await user.reload();
    user = auth.currentUser!;
    if (user.emailVerified) {
      timer.cancel();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, Routes.fillProfile);
    }
  }
}
