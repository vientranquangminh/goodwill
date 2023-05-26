import 'package:flutter/material.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:intl/intl.dart';

class InputDate extends StatefulWidget {
  InputDate(
      {Key? key,
      required this.dateInput,
      required this.date,
      required this.getDateChange,
      required this.isDateChange})
      : super(key: key);

  final Function(bool value) getDateChange;
  final TextEditingController dateInput;
  final String date;
  bool isDateChange;

  @override
  State<InputDate> createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {
  @override
  void initState() {
    super.initState();
    widget.dateInput.text = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.dateInput,
        readOnly: true,
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          suffixIcon: const Icon(
            Icons.calendar_month,
            color: Colors.grey,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return context.localizations.canNotBeEmpty;
          }
          return null;
        },
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1950),
              lastDate: DateTime.now());
          if (pickedDate != null) {
            // remove this line
            String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
            setState(() {
              widget.getDateChange(true);
              widget.dateInput.text = formattedDate;
            });
          }
        },
      ),
    );
  }
}
