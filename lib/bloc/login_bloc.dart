import 'dart:async';

import '../validators/validations.dart';

class AuthBloc {
  final StreamController _userController = StreamController();
  final StreamController _passController = StreamController();

  Stream get userStream => _userController.stream;
  Stream get passStream => _passController.stream;

  bool isValidInfo(String user, String pass) {
    if (!Validations.isValidUser(user)) {
      _userController.sink.addError('Tài khoản không hợp lệ');
      return false;
    }
    _userController.sink.add('OK');
    if (!Validations.isValidPass(pass)) {
      _passController.sink.addError('Mật khẩu không hợp lệ');
      return false;
    }
    _passController.sink.add('OK');
    return true;
  }

  void dispose() {
    _userController.close();
    _passController.close();
  }
}
