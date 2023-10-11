import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiResponse {
  final String statusCode;
  final String? message;
  final Data data;

  ApiResponse({
    required this.statusCode,
    this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final bool isFirstTime;
  final String token;
  final User user;

  Data({
    required this.isFirstTime,
    required this.token,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      isFirstTime: json['isFirstTime'],
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String id;
  final String email;
  final String fullName;
  final String avatarUrl;
  final String phone;
  final String? birthday;
  final String roleName;

  User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.avatarUrl,
    required this.phone,
    this.birthday,
    required this.roleName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
      avatarUrl: json['avatarUrl'],
      phone: json['phone'],
      birthday: json['birthday'],
      roleName: json['roleName'],
    );
  }
}

class UserService {
  Future<ApiResponse?> getUser(String idToken, String fcmToken) async {
    String url =
        "http://momkitchen.wyvernpserver.tech/api/v1/Authentication/login";
    Uri uri = Uri.parse(url);

    final response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'idToken': idToken,
          'fcmToken': fcmToken,
          'roleName': 'Customer',
        }));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      jsonDecode(response.body);
      // throw Exception('Http Failed: ${response.statusCode}');
    }
  }
}
