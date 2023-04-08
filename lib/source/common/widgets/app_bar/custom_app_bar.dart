import 'package:flutter/material.dart';

import 'app_bar_action.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar(
      {Key? key,
      required this.title,
      this.leading,
      this.actions,
      this.tabBar,
      this.backgroundColor = Colors.black,
      this.iconColor,
      this.titleColor,
      this.elevation = 0.0,
      this.toolbarHeight})
      : super(key: key);
  final String title;
  final List<String>? actions;
  final TabBar? tabBar;
  final double? toolbarHeight;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? titleColor;
  final double? elevation;

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? 65);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: leading,
      iconTheme: IconThemeData(color: iconColor),
      backgroundColor: backgroundColor,
      elevation: elevation,
      title: Text(
        title,
        style: TextStyle(
            color: titleColor, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      actions: actions?.map((e) => AppBarAction(e)).toList(),
      bottom: tabBar,
    );
  }

  @override
  Widget get child => throw UnimplementedError();
}
