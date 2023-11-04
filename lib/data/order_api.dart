import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class OrderApi {
  final Dio _dio = Dio();
  OrderApi() {
    _dio.options.baseUrl = '${AppConstants.localhostAdress}/order';
    _dio.options.contentType = Headers.jsonContentType;
    _dio.options.responseType = ResponseType.json;
  }

  Future<void> createOrder(
      int totalQuantity, String userId, String idMeal) async {
    try {
      Logger log = Logger();
      log.i(totalQuantity);
      log.i(userId);
      log.i(idMeal);
      Response response = await _dio.post('', data: {
        'totalQuantity': totalQuantity,
        'userId': userId,
        'mealId': idMeal,
        'orderPayments': [
          {
            'amount': 0,
            'limitMonth': 0,
            'paymentTypeId': '3fa85f64-5717-4562-b3fc-2c963f66afa6'
          }
        ]
      });
      Logger().i(response.data);
    } catch (error) {
      Logger().e('Error creating Meal: $error');
      throw error;
    }
  }
}
