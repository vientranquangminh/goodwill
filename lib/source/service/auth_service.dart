import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:goodwill/source/enum/firebase_auth_code.dart ';
import 'package:goodwill/source/util/firebase_auth_helper.dart';

class AuthService {
  static final _instance = FirebaseAuth.instance;

  static Stream<User?> get user {
    return _instance.authStateChanges();
  }

  static Future<UserCredential> signInAnonymous() async {
    return _instance.signInAnonymously();
  }

  static Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential? firebaseUser;
    try {
      firebaseUser = await _instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // return firebaseUser;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    }
    return firebaseUser;
  }

  // register wit email & pw
  static Future<UserCredential?> signUp(email, password) async {
    UserCredential? newUserCredential;
    try {
      newUserCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    }
    return newUserCredential;
  }

  // sign out
  static Future<void> signOut() async {
    try {
      return await _instance.signOut();
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    }
  }

  static void _handleAuthError(FirebaseAuthException e) {
    String msg = FirebaseAuthHelper.getToastMessage(e.code);
    Fluttertoast.showToast(msg: msg);
    debugPrint(msg);
  }
}
