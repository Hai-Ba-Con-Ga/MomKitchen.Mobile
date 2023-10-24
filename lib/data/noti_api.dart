import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class NotiApi {
  final Dio _dio = Dio();

  NotiApi() {
    _dio.options.baseUrl = '${AppConstants.localhostAdress}/notification';
    _dio.options.contentType = Headers.jsonContentType;
    _dio.options.responseType = ResponseType.json;
  }

  Future<void> pushNoti() async {
    var log = Logger();
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    log.i('userId : $userId');
    await _dio.post('', data: {
      'title': 'MomKitchen',
      'content': 'Đơn hàng của bạn đã được đặt thành công !',
      'receiverId': userId,
      'sentTime': '2023-10-19T21:18:18.253Z'
    });
  }
}
