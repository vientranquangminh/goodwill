import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goodwill/source/data/model/user_profile.dart';

class UserProfileRepository {
  CollectionReference userProfilesRef =
      FirebaseFirestore.instance.collection('userProfiles');

  void _debugPrint(String s) {
    const className = 'UserProfileRepository';
    debugPrint('$className: $s');
  }

  Future<void> add(UserProfile userProfile) async {
    if (await isUserProfileExist(userProfile)) {
      _debugPrint('UserProfile already exists');
      return;
    }

    final id = userProfile.id;
    DocumentReference newDocRef = userProfilesRef.doc(id);

    newDocRef
        .set(userProfile.toMap())
        .then((value) => debugPrint('User ${userProfile.fullName} added'))
        .onError((error, stackTrace) {
      _debugPrint('Error $error');
      _debugPrint('Stack $stackTrace');
    });
  }

  Future<UserProfile?> get(String id) async {
    final docRef = userProfilesRef.doc(id).withConverter(
        fromFirestore: UserProfile.fromFirestore,
        toFirestore: (UserProfile userProfile, _) => userProfile.toMap());
    final docSnap = await docRef.get();
    final userProfile = docSnap.data();
    if (userProfile == null) {
      _debugPrint('No document with docId-$id found');
    }
    return userProfile;
  }

  // TODO: Update
  void update(UserProfile userProfile) {}

  Future<void> delete(UserProfile userProfile) async {
    final id = userProfile.id;
    await userProfilesRef.doc(id).delete();
    _debugPrint('Delete user ${userProfile.id} complete');
  }

  Future<bool> isUserProfileExist(UserProfile userProfile) async {
    final id = userProfile.id;
    final doc = await userProfilesRef.doc(id).get();
    return doc.exists;
  }
}
