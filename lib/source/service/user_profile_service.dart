import 'package:firebase_auth/firebase_auth.dart';
import 'package:goodwill/source/data/model/user_profile.dart';
import 'package:goodwill/source/data/repository/user_profile_repository.dart';

class UserProfileService {
  static UserProfileRepository _userProfileRepository =
      new UserProfileRepository();

  static void addUserProfile(UserProfile userProfile) {
    _userProfileRepository.add(userProfile);
  }

  static void deleteUserProfile(UserProfile userProfile) {
    _userProfileRepository.delete(userProfile);
  }
}
