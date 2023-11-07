import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../model/kitchen_model.dart';
import '../utils/constants.dart';

class KitchenApi {
  final Dio _dio = Dio();
  KitchenApi() {
    _dio.options.baseUrl = '${AppConstants.localhostAdress}/kitchen';
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

  //edit kitchen
  Future<void> editKitchen(String kitchenId, KitchenRequest kitchen) async {
    try {
      Response response = await _dio.put('/$kitchenId', data: kitchen.toRawJson());
      Logger().i(response.data);
    } catch (error) {
      Logger().e("Error updating Dish: $error");
      throw error;
    }
  }

  //get kitchen
  Future<Kitchen> getKitchen(String kitchenId) async {
    try {
      Response response = await _dio.get('/$kitchenId');
      Logger().i(response.data);
      return Kitchen.fromJson(response.data['data']);
    } catch (error) {
      Logger().e("Error getting Dish: $error");
      throw error;
    }
  }
}
