import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/auth_model.dart';
import '../utils/constants.dart';

class UserApi {
  final Dio _dio = Dio();

  UserApi() {
    _dio.options.baseUrl = '${AppConstants.localhostAdress}/user/';
    _dio.options.contentType = Headers.jsonContentType;
    _dio.options.responseType = ResponseType.json;
  }

  Future<User?> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString('userId');

    Response response = await _dio.get(userID!);

    return User.fromJson(response.data['data']);
  }

  Future<void> editUserInfo(String usernameController, String emailController,
      String phoneController, String avatarUrl, birthday) async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString('userId');

    Response response = await _dio.put(userID!, data: {
      'email': emailController,
      'fullName': usernameController,
      'avatarUrl': avatarUrl,
      'phone': phoneController,
      'birthday': birthday
    });
  }
}
