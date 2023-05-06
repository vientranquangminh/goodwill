import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer(
      {super.key,
      this.title = '',
      this.color,
      this.padding = 0.0,
      this.radius = 0,
      this.titleStyle});

  final String title;
  final Color? color;
  final double radius;
  final TextStyle? titleStyle;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 10,
      ),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(radius.r),
        ),
      ),
      child: Text(
        title,
        style: titleStyle,
      ),
    );
  }
}
