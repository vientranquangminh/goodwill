import 'package:flutter/material.dart';
import 'package:goodwill/gen/colors.gen.dart';

class InputEmail extends StatelessWidget {
  const InputEmail({
    Key? key, required this.controller,
  }) : super(key: key);
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
          child: Row(
            children: const [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                      hintStyle: TextStyle(
                          color: ColorName.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.email_outlined),
              )
            ],
          ),
        ),
      ),
    );
  }
}
