import 'package:flutter/material.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';

class EditDateOfBirthAdmin extends StatefulWidget {
  const EditDateOfBirthAdmin(
      {Key? key, required this.dateInput, required this.date})
      : super(key: key);

  @override
  State<EditDateOfBirthAdmin> createState() => _EditDateOfBirthAdminState();
  final TextEditingController dateInput;
  final String date;
}

class _EditDateOfBirthAdminState extends State<EditDateOfBirthAdmin> {
  @override
  void initState() {
    widget.dateInput.text = widget.date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.dateInput,
      readOnly: true,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        hintText: widget.date.toString(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: const Icon(
          Icons.calendar_month,
          color: Colors.black,
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
          // String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          setState(() {
            widget.dateInput.text = pickedDate.toString();
          });
        }
      },
    );
  }
}
