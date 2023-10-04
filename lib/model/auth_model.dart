import 'package:firebase_auth/firebase_auth.dart';

class AuthInfoModel {
  AuthInfoModel._instance();

  UserCredential? userCredential;

  static AuthInfoModel instance = AuthInfoModel._instance();

  factory AuthInfoModel() {
    return instance;
  }
}
