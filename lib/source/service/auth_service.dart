import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final _instance = FirebaseAuth.instance;

  static Stream<User?> get user {
    return _instance.authStateChanges();
  }

  static Future<UserCredential> signInAnonymous() {
    return _instance.signInAnonymously();
  }
}
