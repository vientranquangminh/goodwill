import 'package:flutter/material.dart';

class AppBarAdmin extends StatelessWidget {
  const AppBarAdmin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(width: 10),
        IconButton(
            icon: const Icon(
              Icons.notifications_active,
              size: 20,
            ),
            onPressed: () {}),
        const SizedBox(width: 15),
        Row(children: const [
          CircleAvatar(
            radius: 17,
            backgroundImage: AssetImage("assets/images/profile/avatar.jpg"),
          ),
          Icon(Icons.arrow_drop_down_outlined, color: Colors.black)
        ]),
      ],
    );
  }
}
