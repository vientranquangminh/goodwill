import 'package:goodwill/source/enum/firebase_auth_code.dart';

class FirebaseAuthHelper {
  static String getToastMessage(String s) {
    String res = '';
    switch (s) {
      case FirebaseAuthExceptionCode.USER_NOT_FOUND:
        res = 'Can not find user';
        break;
      case FirebaseAuthExceptionCode.WRONG_PASSWORD:
        res = 'Your password is incorrect';
        break;
      case FirebaseAuthExceptionCode.EMAIL_ALREADY_IN_USE:
        res = 'This email is already in used';
        break;
      case FirebaseAuthExceptionCode.INVALID_EMAIL:
        res = 'Your email is invalid';
        break;
      case FirebaseAuthExceptionCode.NOT_ALLOWED:
        res = 'Your operation is not allowed';
        break;
      case FirebaseAuthExceptionCode.WEAK_PASSWORD:
        res = 'Your password is too weak, please try another strong password';
        break;
    }
    return res;
  }
}
