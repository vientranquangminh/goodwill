import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:goodwill/source/data/model/user_profile.dart';
import 'package:goodwill/source/data/repository/user_profile_repository.dart';
import 'package:goodwill/source/service/auth_service.dart';
import 'package:goodwill/source/util/file_helper.dart';

import 'cloud_storage_service.dart';

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

  static Stream<UserProfile?> getMyUserProfileStream() {
    return _userProfileRepository.getStream(AuthService.userId ?? '');
  }

  static Future<UserProfile?> getTestUserProfile() async {
    return _userProfileRepository.get('test');
  }

  static void updateUserProfile(UserProfile userProfile) {
    _userProfileRepository.update(userProfile);
  }

  static void deleteUserProfile(UserProfile userProfile) {
    _userProfileRepository.delete(userProfile);
  }

  static Future<TaskSnapshot?> updateProfilePicture(File file) async {
    final res = await _uploadFileToCloudStorage(file);
    if (res != null) {
      String newProfilePicture = await res.ref.getDownloadURL();
      debugPrint(newProfilePicture);
      final currenUserProfile = await getMyUserProfile();
      currenUserProfile!.profilePicture = newProfilePicture;

      updateUserProfile(currenUserProfile);
    }
  }

  static Future<TaskSnapshot?> _uploadFileToCloudStorage(File file) async {
    final user = AuthService.user;
    if (user == null) return null;

    // String extension = FileHelper.getFileExtension(file);
    // String dest = 'images/users/${user.email}/profilePicture/avatar$extension';

    String dest = FileHelper.getStorageAvatarPath(file);

    try {
      return CloudStorageService.uploadImage(file, destination: dest);
    } on FirebaseException catch (e) {
      debugPrint('Error to load this image ${e.message}');
    }
    return null;
  }
}
