import 'package:flutter/material.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';

class InputPhoneNumber extends StatelessWidget {
  const InputPhoneNumber({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(color: ColorName.black),
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          children: [
            const Text("(+84)"),
            const SizedBox(width: 5),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: VerticalDivider(
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: context.localizations.plsEnterYourPhone,
                      hintStyle: const TextStyle(
                          color: ColorName.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
