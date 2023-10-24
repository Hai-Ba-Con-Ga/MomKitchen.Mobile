import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../model/auth_model.dart';
import '../utils/constants.dart';

class AuthApi {
  final Dio _dio = Dio();

  AuthApi() {
    _dio.options.baseUrl = '${AppConstants.domainAddress}/Authentication/login';
    _dio.options.contentType = Headers.jsonContentType;
    _dio.options.responseType = ResponseType.json;
  }

  Future<ResponseUser?> loginUser(String idToken, String fcmToken, [String? roleName]) async {
    var jsondata = {'idToken': idToken, 'fcmToken': fcmToken, 'roleName': roleName ?? 'Customer'};
    Response response = await _dio.post('', data: jsondata);
    Logger().i(ResponseUser.fromJson(response.data['data']).user.roleName);
    return ResponseUser.fromJson(response.data['data']);
  }
}
