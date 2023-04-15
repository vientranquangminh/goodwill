import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

class AppBarAction extends StatelessWidget {

  final String action;

  const AppBarAction(this.action, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          log("HomePage");
        },
        icon: SvgPicture.asset(action));
  }
}
