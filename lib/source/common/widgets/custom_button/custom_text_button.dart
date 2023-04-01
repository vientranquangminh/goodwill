import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, 
  this.buttonColor = Colors.blue, 
  this.textColor = Colors.black, 
  required this.text, 
  this.fontSize = 10, 
  required this.customFunction});
  
  final Color buttonColor;
  final Color textColor;
  final String text;
  final double fontSize;
  final VoidCallback customFunction;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: customFunction,
        style: ButtonStyle(
            shape: MaterialStateProperty.all( RoundedRectangleBorder(
                side: BorderSide(color: buttonColor),
                borderRadius: const BorderRadius.all(Radius.circular(20))))),
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize, color: textColor),
        ));
  }
}
