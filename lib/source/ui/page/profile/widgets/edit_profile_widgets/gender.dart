import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GenderEditProfile extends StatefulWidget {
  GenderEditProfile({
    Key? key,
    required this.gender,
    required this.getText,
  }) : super(key: key);
  final Function(String value) getText;
  String gender;

  @override
  State<GenderEditProfile> createState() => _GenderEditProfileState();
}

class _GenderEditProfileState extends State<GenderEditProfile> {
  String? dropDownValue;
  var items = [
    'Male',
    'Female',
    'Others',
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: InputDecorator(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          isEmpty: dropDownValue == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: dropDownValue,
              hint: Text(widget.gender),
              isDense: true,
              onChanged: (value) {
                widget.getText(value ?? '');
                _getGender(value);
                dropDownValue = value!;
              },
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          )),
    );
  }

  _getGender(value) {
    if (value != null) {
      setState(() {
        widget.gender = value;
      });
    }
  }
}
