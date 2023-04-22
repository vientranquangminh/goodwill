import 'package:flutter/material.dart';
import 'package:goodwill/gen/colors.gen.dart';

// ignore: must_be_immutable
class DropAction extends StatefulWidget {
  DropAction({
    required this.items,
    required this.selectedItem,
    Key? key,
  }) : super(key: key);
  List<String> items;
  String selectedItem;
  @override
  State<DropAction> createState() => _DropActionScheduleState();
}

class _DropActionScheduleState extends State<DropAction> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0),
      child: Container(
        height: 48,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border.all(color: ColorName.black),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:16.0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              elevation: 8,
              value: widget.selectedItem,
              isExpanded: true,
              onChanged: (newValue) {
                setState(() {
                  widget.selectedItem = newValue!;
                });
              },
              items: widget.items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class DropNation extends StatelessWidget {
  const DropNation({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> items = ['United States', 'Viet Nam','Korea'];
    return DropAction(
      items: items,
      selectedItem: 'United States',
    );
  }
}

class DropGender extends StatelessWidget {
  const DropGender({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> items = ['Male', 'Female'];
    return DropAction(
      items: items,
      selectedItem: 'Male',
    );
  }
}
