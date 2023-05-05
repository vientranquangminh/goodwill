import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditGender extends StatefulWidget {
  EditGender({
    Key? key,
    required this.getText,
    required this.gender,
  }) : super(key: key);

  @override
  State<EditGender> createState() => _EditGenderState();
  final Function(String value) getText;
  String gender;
}

class _EditGenderState extends State<EditGender> {
  String? dropDownValue;
  var items = [
    'Male',
    'Female',
    'Others',
  ];
  @override
  Widget build(BuildContext context) {
    return InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        isEmpty: dropDownValue == '',
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint: Text(widget.gender),
            value: dropDownValue,
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
        ));
  }

  _getGender(value) {
    if (value != null) {
      setState(() {
        widget.gender = value;
      });
    }
  }
}
