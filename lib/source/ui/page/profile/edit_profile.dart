import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/app_bar/custom_app_bar.dart';
import 'package:goodwill/source/common/widgets/app_toast/app_toast.dart';
import 'package:goodwill/source/common/widgets/custom_button/primary_button.dart';
import 'package:goodwill/source/data/model/user_profile.dart';
import 'package:goodwill/source/service/auth_service.dart';
import 'package:goodwill/source/service/user_profile_service.dart';
import 'package:goodwill/source/ui/page/profile/widgets/edit_profile_widgets/gender.dart';
import 'package:goodwill/source/ui/page/profile/widgets/edit_profile_widgets/input_date.dart';
import 'package:intl/intl.dart';

import 'widgets/edit_profile_widgets/textfield_custom.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _dateInput = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String textGender = 'Male';
  bool isDateChange = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          backgroundColor: ColorName.white,
          title: context.localizations.editProfile,
          titleColor: ColorName.black,
          leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
            child: FutureBuilder(
          future: UserProfileService.getMyUserProfile(),
          builder:
              (BuildContext context, AsyncSnapshot<UserProfile?> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong :(');
            }
            if (snapshot.data == null ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: const [
                  CircularProgressIndicator(),
                ],
              );
            }
            UserProfile? userProfile = snapshot.data;
            _nameController.text = userProfile!.fullName ?? '';
            _nicknameController.text = userProfile.nickName ?? '';
            _phoneNumberController.text = userProfile.phoneNumber ?? '';
            _addressController.text = userProfile.address ?? '';
            return Column(children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFieldCustom(
                      controller: _nameController,
                      hint: context.localizations.fullName,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return context.localizations.canNotBeEmpty;
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFieldCustom(
                      controller: _nicknameController,
                      hint: context.localizations.nickname,
                    ),
                    InputDate(
                      isDateChange: isDateChange,
                      getDateChange: (value) => _checkDateChange(value),
                      dateInput: _dateInput,
                      date: DateFormat('dd-MM-yyyy')
                          .format(userProfile.dateOfBirth ?? DateTime.now()),
                    ),
                    GenderEditProfile(
                      gender: userProfile.gender ?? "Others",
                      getText: (value) => _getTextGender(value),
                    ),
                    TextFieldCustom(
                      suffixIcon: const Icon(Icons.phone_android),
                      hint: context.localizations.phoneNumber,
                      keyboardType: TextInputType.number,
                      controller: _phoneNumberController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return context.localizations.plsEnterYourPhone;
                        } else if (value!.length > 10 ||
                            value[0] != '0' ||
                            value.length < 10) {
                          return context.localizations.plsEnterValid;
                        } else if (value[0] == '0' && value[1] == '0') {
                          return context.localizations.plsEnterValid;
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFieldCustom(
                      hint: context.localizations.address,
                      controller: _addressController,
                      suffixIcon: const Icon(Icons.location_on_sharp),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return context.localizations.canNotBeEmpty;
                        } else {
                          return null;
                        }
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: PrimaryButton(
                    radius: 40.r,
                    customFunction: () {
                      if (_formKey.currentState!.validate()) {
                        log(textGender);
                        log('Updated');
                        AppToasts.showToast(
                            context: context,
                            title: context.localizations.updateSuccessfully);

                        String fullName = _nameController.text;
                        String nickName = _nicknameController.text;
                        DateTime dob =
                            DateFormat('dd-MM-yyyy').parse(_dateInput.text);
                        String gender = textGender;
                        String phoneNumber = _phoneNumberController.text;
                        String address = _addressController.text;

                        UserProfile up = UserProfile(
                          id: AuthService.userId!,
                          fullName: fullName,
                          nickName: nickName,
                          dateOfBirth: dob,
                          gender: gender,
                          phoneNumber: phoneNumber,
                          address: address,
                        );

                        UserProfileService.updateUserProfile(up);
                      } else {
                        AppToasts.showErrorToast(
                            context: context,
                            title: context.localizations.updateFailed);
                      }
                    },
                    text: context.localizations.update,
                    buttonColor: ColorName.black,
                    fontSize: 16,
                    textColor: ColorName.white,
                  ),
                ),
              )
            ]);
          },
        )));
  }

  _getTextGender(value) {
    if (value != null) {
      textGender = value;
    }
  }

  _checkDateChange(value) {
    if (value != null) {
      isDateChange = value;
    }
  }
}
