import 'package:firebase_auth/firebase_auth.dart';
import 'package:goodwill/source/data/model/user_profile.dart';
import 'package:goodwill/source/data/repository/user_profile_repository.dart';

class UserProfileService {
  static final UserProfileRepository _userProfileRepository =
      UserProfileRepository();

  static void addUserProfile(UserProfile userProfile) {
    _userProfileRepository.add(userProfile);
  }

  static Future<UserProfile?> getUserProfile(String id) async {
    return _userProfileRepository.get(id);
  }

  static void deleteUserProfile(UserProfile userProfile) {
    _userProfileRepository.delete(userProfile);
  }
}
