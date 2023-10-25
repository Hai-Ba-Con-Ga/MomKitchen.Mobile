import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../model/kitchen_model.dart';
import '../utils/constants.dart';

class KitchenApi {
  final Dio _dio = Dio();
  KitchenApi() {
    _dio.options.baseUrl = '${AppConstants.domainAddress}/kitchen';
    _dio.options.contentType = Headers.jsonContentType;
    _dio.options.responseType = ResponseType.json;
  }

  Future<void> createKitchen(KitchenRequest kitchen) async {
    try {
      Logger().i(kitchen.toRawJson());
      Response response = await _dio.post('', data: kitchen);
      Logger().i(response.data);
    } catch (error) {
      Logger().e("Error creating Dish: $error");
      throw error;
    }
  }
}
