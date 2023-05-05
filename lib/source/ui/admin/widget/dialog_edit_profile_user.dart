import 'package:flutter/material.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/app_toast/app_toast.dart';
import 'package:goodwill/source/common/widgets/custom_button/primary_button.dart';

import 'components/edit_day_of_birth_admin.dart';
import 'components/edit_gender.dart';

class EditUserInformation extends StatefulWidget {
  const EditUserInformation({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  State<EditUserInformation> createState() => _EditUserInformationState();
}

class _EditUserInformationState extends State<EditUserInformation> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _dateInputController = TextEditingController();
  String? textGender;
  @override
  void dispose() {
    super.dispose();
    _phoneNumberController.dispose();
    _nameController.dispose();
    _nickNameController.dispose();
    _dateInputController.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: SizedBox(
          child: Column(
            children: [
              Text(
                context.localizations.editProfile,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        content: SizedBox(
          height: 400,
          child: Column(
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _nameController,
                decoration: InputDecoration(
                    hintText: context.localizations.fullName,
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(8))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter user name';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _nickNameController,
                decoration: InputDecoration(
                    hintText: context.localizations.nickname,
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(8))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter nick name of user';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneNumberController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter phone number of user";
                  } else if (value.length > 10 ||
                      value[0] != '0' ||
                      value.length < 10) {
                    return "Please enter valid phone number";
                  } else if (value[0] == '0' && value[1] == '0') {
                    return "Please enter valid phone number";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: context.localizations.phoneNumber,
                    prefixIcon: const Icon(
                      Icons.phone_android,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(8),
                    )),
              ),
              const SizedBox(height: 10),
              EditDateOfBirthAdmin(
                dateInput: _dateInputController,
                date: '',
                // snapshot.data?.get('dateOfBirth'),
              ),
              const SizedBox(height: 10),
              EditGender(
                getText: (value) => _getTextGender(value),
                gender: 'Male',
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        actions: <Widget>[
          Container(
              height: 40,
              width: MediaQuery.of(context).size.width / 3,
              margin: const EdgeInsets.all(20),
              child: PrimaryButton(
                radius: 16,
                buttonColor: Colors.black,
                customFunction: () {
                  if (_formKey.currentState!.validate()) {
                    AppToasts.showToast(
                        context: context, title: 'Update successfully');
                    Navigator.pop(context);
                  }
                },
                fontSize: 16,
                text: context.localizations.submit,
                textColor: Colors.white,
              ))
        ],
      ),
    );
  }

  _getTextGender(value) {
    if (value != null) {
      textGender = value;
    }
  }
}
