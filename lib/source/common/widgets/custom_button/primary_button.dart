import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      this.buttonColor = Colors.blue,
      this.textColor = Colors.black,
      required this.text,
      this.fontSize = 10,
      this.radius = 0.0,
      required this.customFunction});

  final Color buttonColor;
  final Color textColor;
  final String text;
  final double fontSize;
  final VoidCallback customFunction;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: customFunction,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonColor),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius))))),
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize, color: textColor),
        ));
  }
}
