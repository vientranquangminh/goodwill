import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/source/data/model/user_profile.dart';
import 'package:goodwill/source/service/user_profile_service.dart';
import 'package:goodwill/source/ui/page/sign_in/component/custom_texfield.dart';
import 'package:goodwill/source/ui/page/sign_in/component/gender.dart';
import 'package:goodwill/source/ui/page/sign_in/component/input_date_of_birth.dart';

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
                                icon: SvgPicture.asset(
                                  'assets/svgs/edit-pen.svg',
                                  color: Colors.white,
                                ),
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
                      // showDialog(
                      //   context: context,
                      //   builder: (context) => const DialogBuilder(),
                      // );
                      // Timer(const Duration(seconds: 3), () {
                      //   Navigator.pushNamed(context, Routes.pageController);
                      // });

                      // TODO: Add a new profile if not exist
                    }
                    UserProfileService.addUserProfile(UserProfile.sample);
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

  _getGender(value) {
    if (value != null) {
      setState(() {
        textGender = value;
      });
    }
  }
}
