import '../data/auth_api.dart';
import '../model/auth_model.dart';

class AuthRepository {
  final AuthApi _authApi;
  AuthRepository({required AuthApi authApi}) : _authApi = authApi;
  Future<ResponseUser?> loginUser(String idToken, String fcmToken,
      [String? roleName]) {
    return _authApi.loginUser(idToken, fcmToken, roleName);
  }
}
