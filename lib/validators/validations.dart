class Validations {
  static bool isValidUser(String? username) {
    return username != null && username.length > 3 && !username.contains(' ');
  }
  static bool isValidPass(String? password) {
    return password != null && password.length > 3 && !password.contains(' ');
  }
}