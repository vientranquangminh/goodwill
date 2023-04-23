import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:goodwill/source/data/model/user_profile.dart';
import 'package:goodwill/source/data/repository/user_profile_repository.dart';
import 'package:goodwill/source/service/auth_service.dart';

class UserProfileService {
  UserProfileService._();

  static final UserProfileRepository _userProfileRepository =
      UserProfileRepository();

  static void addUserProfile(UserProfile userProfile) {
    _userProfileRepository.add(userProfile);
  }

  static Future<UserProfile?> getUserProfile(String id) async {
    return _userProfileRepository.get(id);
  }

  static Future<UserProfile?> getMyUserProfile() async {
    return _userProfileRepository.get(AuthService.userId ?? '');
  }

  static Future<UserProfile?> getTestUserProfile() async {
    return _userProfileRepository.get('test');
  }

  static void deleteUserProfile(UserProfile userProfile) {
    _userProfileRepository.delete(userProfile);
  }
}
