import 'package:flutter/material.dart';
import 'package:goodwill/source/common/widgets/custom_button/custom_elevated_button.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    Key? key,
    required this.title,
    required this.content,
    required this.negativeButtonText,
    required this.positiveButtonText,
    required this.negativeButtonFunction,
    required this.positiveButtonFunction,
    required this.bottomSheetHeight,
    this.titleColor = Colors.black,
    this.negativeButtonColor = Colors.lightBlue,
    this.positiveButtonColor = Colors.blue,
    this.negativeTextColor = Colors.black,
    this.positiveTextColor = Colors.black
  }) : super(key: key);

  final String title;
  final Widget content;
  final Color titleColor;
  final String negativeButtonText;
  final Color negativeButtonColor;
  final Color negativeTextColor;
  final String positiveButtonText;
  final Color positiveButtonColor;
  final Color positiveTextColor;
  final VoidCallback negativeButtonFunction;
  final VoidCallback positiveButtonFunction;
  final double bottomSheetHeight;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: bottomSheetHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                  color: titleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Divider(thickness: 1),
            ),
            content,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  width: size.width / 3,
                  height: size.height / 18,
                  child: CustomElevatedButton(
                    text: negativeButtonText,
                    buttonColor: negativeButtonColor,
                    textColor: negativeTextColor,
                    fontSize: 15,
                    customFunction: negativeButtonFunction,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  width: size.width / 3,
                  height: size.height / 18,
                  child: CustomElevatedButton(
                    text: positiveButtonText,
                    buttonColor: positiveButtonColor,
                    textColor: positiveTextColor,
                    fontSize: 15,
                    customFunction: positiveButtonFunction,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
