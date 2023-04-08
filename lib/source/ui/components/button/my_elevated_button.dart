import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton(
      {super.key,
      required this.buttonColor,
      required this.textColor,
      required this.text,
      required this.fontSize,
      required this.customFunction});
  final Color buttonColor;
  final Color textColor;
  final String text;
  final double fontSize;
  final VoidCallback customFunction;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: customFunction,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonColor),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))))),
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize, color: textColor),
        ));
  }
}
