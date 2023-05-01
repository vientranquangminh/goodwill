import 'package:flutter/material.dart';

class CustomTopicContainer extends StatelessWidget {
  const CustomTopicContainer(
      {Key? key,
      required this.hour,
      required this.buttonColor,
      required this.textColor})
      : super(key: key);
  final String hour;
  final Color buttonColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      width: 100,
      decoration: BoxDecoration(
        color: buttonColor,
        border: Border.all(color: Colors.black, width: 1.5),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Center(
          child: Text(
            hour,
            style: TextStyle(color: textColor, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
