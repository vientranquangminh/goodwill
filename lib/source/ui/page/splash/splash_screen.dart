// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goodwill/source/service/auth_service.dart';
import 'package:goodwill/source/ui/admin/admin_screen.dart';
import 'package:goodwill/source/ui/components/page_controller.dart';
import 'package:goodwill/source/ui/page/auth_wrapper/auth_wrapper.dart';
import 'package:goodwill/source/ui/page/splash/widget/onboarding.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    {
      Timer(const Duration(seconds: 3), () async {
        var _stream = AuthService.authChanges;
        if (kIsWeb) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const AdminScreen()),
          );
        } else if (await _stream.first != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const AuthWrapper()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const OnBoardingPage()),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.grey.shade800, Colors.black])),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/splash/splash.png'),
              const Spacer(),
              const SizedBox(
                width: 80,
                height: 80,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballRotateChase,
                  strokeWidth: 2,
                  colors: [Colors.white],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
