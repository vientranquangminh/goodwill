import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/widgets/custom_button/primary_button.dart';

class BottomSheetLogout extends StatelessWidget {
  final String text;
  final Widget content;
  final String buttonText1;
  final String buttonText2;
  final VoidCallback function1;
  final VoidCallback function2;
  const BottomSheetLogout({
    Key? key,
    required this.text,
    required this.content,
    required this.buttonText1,
    required this.buttonText2,
    required this.function1,
    required this.function2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        child: Column(
          children: [
            Text(
              text,
              style: const TextStyle(
                  color: ColorName.alert,
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
                  child: PrimaryButton(
                    radius: 40.r,
                    text: buttonText1,
                    buttonColor: ColorName.black,
                    textColor: ColorName.white,
                    fontSize: 15,
                    customFunction: function1,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  width: size.width / 3,
                  height: size.height / 18,
                  child: PrimaryButton(
                    radius: 40.r,
                    text: buttonText2,
                    buttonColor: ColorName.black,
                    textColor: ColorName.white,
                    fontSize: 15,
                    customFunction: function2,
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
