import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../model/auth_model.dart';
import '../utils/constants.dart';

class AuthApi {
  final Dio _dio = Dio();

  AuthApi() {
    _dio.options.baseUrl = '${AppConstants.domainAddress}/Authentication';
    _dio.options.contentType = Headers.jsonContentType;
    _dio.options.responseType = ResponseType.json;
  }

  Future<ResponseUser?> loginUser(
      String idToken, String fcmToken, String? roleName) async {
    Response response = await _dio.post('/login', data: {
      'idToken': idToken,
      'fcmToken': fcmToken,
      'roleName': 'Customer'
    });
    var log = Logger();
    // log.i(ResponseUser.fromJson(response.data['data']).isFirstTime);
    log.i(ResponseUser.fromJson(response.data['data']).user.id);
    log.i('fcmToken $fcmToken');
    return ResponseUser.fromJson(response.data['data']);
  }

  // Future<ResponseUser> logout(String fcmToken) async {
  //   Response response = await _dio.delete('', data: {
  //     'idToken': idToken,
  //     'fcmToken': fcmToken,
  //     'roleName': 'Customer'
  //   });
  // }
}
