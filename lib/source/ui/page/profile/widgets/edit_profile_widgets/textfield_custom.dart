import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom(
      {Key? key,
      required this.hint,
      this.suffixIcon,
      this.validator,
      required this.controller,
      this.labelStyle,
      this.keyboardType})
      : super(key: key);
  final String hint;
  final Icon? suffixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextStyle? labelStyle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          suffixIcon: suffixIcon,
          hintText: hint,
          labelStyle: labelStyle,
        ),
        validator: validator,
      ),
    );
  }
}
