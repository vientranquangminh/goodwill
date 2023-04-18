import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/source/data/model/user_profile.dart';
import 'package:goodwill/source/service/auth_service.dart';
import 'package:goodwill/source/service/user_profile_service.dart';
import 'package:goodwill/source/ui/page/sign_in/component/custom_texfield.dart';
import 'package:goodwill/source/ui/page/sign_in/component/gender.dart';
import 'package:goodwill/source/ui/page/sign_in/component/input_date_of_birth.dart';
import 'package:intl/intl.dart';

import '../../../routes.dart';
import 'component/show_dialog.dart';

class FillProfileScreen extends StatefulWidget {
  const FillProfileScreen({Key? key}) : super(key: key);

  @override
  State<FillProfileScreen> createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends State<FillProfileScreen> {
  final TextEditingController _dateInput = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _datetimeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String? textGender;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneNumberController.dispose();
    _nameController.dispose();
    _nicknameController.dispose();
    _datetimeController.dispose();
    _dateInput.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Fill Your Profile')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 65,
                            backgroundImage:
                                AssetImage(Assets.images.homePage.person.path),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            left: 230,
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8)),
                              child: IconButton(
                                icon: Assets.svgs.editPen.svg(),
                                onPressed: () {},
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomTextFiled(
                      controller: _nameController,
                      hint: 'Full name',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Can not be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomTextFiled(
                      controller: _nicknameController,
                      hint: 'Nick name',
                    ),
                    InputAge(dateInput: _dateInput),
                    Gender(
                      onChanged: (value) => _getGender(value),
                    ),
                    CustomTextFiled(
                      surfixIcon: const Icon(
                        Icons.phone_android,
                        color: Colors.black,
                      ),
                      hint: 'Phone number',
                      keyboardType: TextInputType.number,
                      controller: _phoneNumberController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your phone number";
                        } else if (value.length > 11 || value[0] != '0') {
                          return "Please enter valid phone number";
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomTextFiled(
                      hint: 'Address',
                      controller: _addressController,
                      surfixIcon: const Icon(
                        Icons.location_on_sharp,
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Can not be empty';
                        } else {
                          return null;
                        }
                      },
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) => const DialogBuilder(),
                      );
                      Timer(const Duration(seconds: 3), () {
                        Navigator.pushNamed(context, Routes.myPageController);
                      });

                      // TODO: Add a new profile if not exist

                      final DateFormat format = DateFormat('dd-MM-yyyy');

                      final submitUserProfile = UserProfile(
                        id: AuthService.userId ?? "Abc",
                        fullName: _nameController.text,
                        phoneNumber: _phoneNumberController.text,
                        address: _addressController.text,
                        gender: textGender,
                        dateOfBirth: format.parse(_dateInput.text),
                        nickName: _nicknameController.text,
                      );
                      print(submitUserProfile);
                      UserProfileService.addUserProfile(submitUserProfile);
                    }
                    // test when press 'sign up' button
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.black),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _testFillProfile() async {
    // _addSampleUserProfileWithCurrentUserId();
    _getMyUserProfile();
  }

  Future<void> _getMyUserProfile() async {
    final myUid = AuthService.userId;
    UserProfile? currentUserProfile =
        await UserProfileService.getUserProfile(myUid ?? '');
    debugPrint('current userProfile: ${currentUserProfile?.toJson()}');
  }

  void _addSampleUserProfileWithCurrentUserId() {
    final submitUserProfile = UserProfile.sample;
    if (AuthService.userId != null) {
      submitUserProfile.id = AuthService.userId!;
    } else {
      debugPrint('No user Id');
    }
    UserProfileService.addUserProfile(submitUserProfile);
  }

  _getGender(value) {
    if (value != null) {
      setState(() {
        textGender = value;
      });
    }
  }
}
