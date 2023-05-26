import 'package:flutter/material.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(title: Text(context.localizations.personalProfile)),
    );
  }
}
