import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/data/model/user_profile.dart';
import 'package:goodwill/source/routes.dart';
import 'package:goodwill/source/service/auth_service.dart';
import 'package:goodwill/source/service/user_profile_service.dart';
import 'package:goodwill/source/ui/page/sign_in/component/custom_texfield.dart';
import 'package:goodwill/source/ui/page/sign_in/component/gender.dart';
import 'package:goodwill/source/ui/page/sign_in/component/input_date_of_birth.dart';
import 'package:goodwill/source/ui/page/sign_in/component/show_dialog.dart';
import 'package:intl/intl.dart';

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
  String? textGender;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getCurrentLocation();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _phoneNumberController.dispose();
    _nameController.dispose();
    _nicknameController.dispose();
    _dateInput.dispose();
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Locator service is not allowed');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Something went wrong');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('This feature is permanently denined');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
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
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) => const DialogBuilder(),
                      );
                      Timer(const Duration(seconds: 3), () {
                        context.pushNamed(Routes.myPageController);
                      });
                      final DateFormat format = DateFormat('dd-MM-yyyy');

                      Position userPosition = await _getCurrentLocation();
                      String address = await _getCurrentPositionFromCoordinates(userPosition);
                      final submitUserProfile = UserProfile(
                        id: AuthService.userId ?? '',
                        fullName: _nameController.text,
                        phoneNumber: _phoneNumberController.text,
                        gender: textGender,
                        address: address,
                        dateOfBirth: format.parse(_dateInput.text),
                        nickName: _nicknameController.text,
                        userPosition: UserPosition(
                            lat: userPosition.latitude,
                            long: userPosition.longitude),
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

  Future<String> _getCurrentPositionFromCoordinates(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    return placemarks[0].locality.toString();
  }
}
