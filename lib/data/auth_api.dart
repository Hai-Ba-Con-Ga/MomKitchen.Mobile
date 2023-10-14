import 'package:dio/dio.dart';

import '../model/auth_model.dart';
import '../utils/constants.dart';

class AuthApi {
  final Dio _dio = Dio();

  AuthApi() {
    _dio.options.baseUrl = '${AppConstants.domainAddress}/Authentication/login';
    _dio.options.contentType = Headers.jsonContentType;
    _dio.options.responseType = ResponseType.json;
  }

  Future<ResponseUser?> loginUser(String idToken, String fcmToken) async {
    Response response = await _dio.post('', data: {
      'idToken': idToken,
      'fcmToken': fcmToken,
      'roleName': 'Customer'
    });
    print("................................................................");
    print("IS FIRST TIME");
    print(ResponseUser.fromJson(response.data['data']).isFirstTime);
    print(ResponseUser.fromJson(response.data['data']).token);
    return ResponseUser.fromJson(response.data['data']);
  }
}
