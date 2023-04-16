import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(title: const Text("Personal Profile")),
    );
  }
}
