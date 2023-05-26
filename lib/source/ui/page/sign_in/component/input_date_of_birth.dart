import 'package:flutter/material.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:intl/intl.dart';

class InputAge extends StatefulWidget {
  const InputAge({
    Key? key,
    required this.dateInput,
  }) : super(key: key);

  final TextEditingController dateInput;

  @override
  State<InputAge> createState() => _InputAgeState();
}

class _InputAgeState extends State<InputAge> {
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
          hintText: context.localizations.dateOfBirth,
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
              lastDate: DateTime(2100));
          if (pickedDate != null) {
            String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
            setState(() {
              widget.dateInput.text = formattedDate;
            });
          }
        },
      ),
    );
  }
}
