import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/gen/colors.gen.dart';

class PrimaryButtonWithIcon extends StatelessWidget {
  const PrimaryButtonWithIcon(
      {super.key,
      this.buttonColor = Colors.blue,
      this.textColor = Colors.black,
      required this.text,
      this.fontSize = 10,
      this.radius = 0.0,
      required this.svg,
      required this.customFunction});

  final Color buttonColor;
  final Color textColor;
  final String text;
  final double fontSize;
  final VoidCallback customFunction;
  final double radius;
  final SvgPicture svg;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: customFunction,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonColor),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius))))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            svg,
            SizedBox(
              width: 12.w,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                color: textColor,
              ),
            ),
          ],
        ));
  }
}
