import 'package:flutter/material.dart';
import 'package:goodwill/gen/colors.gen.dart';


class InputText extends StatelessWidget {
  const InputText({
    Key? key,
    required this.hint, required this.controller,
  }) : super(key: key);
  final String hint;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 48,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border.all(color: ColorName.black),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: const TextStyle(
                    color: ColorName.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400)),
          ),
        ),
      ),
    );
  }
}
