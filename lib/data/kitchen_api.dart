import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../model/kitchen_model.dart';
import '../model/meal_detail_model.dart';
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

  Future<List<Kitchen>> getAllKitchens() async {
    try {
      Response response = await _dio.get('/', queryParameters: {
        'PageNumber': '1',
        'PageSize': '10',
        // 'OrderBy': 'createdDate:desc',
      });
      List<dynamic> KitchenData = response.data['data'] as List<dynamic>;
      List<Kitchen> Kitchens =
          KitchenData.map((data) => Kitchen.fromJson(data)).toList();
      return Kitchens;
    } catch (error) {
      Logger().e("Error creating Dish: $error");
      throw error;
    }
  }

  Future<List<MealDetailResponse>> getAllMealKitchens(String kitchenId) async {
    try {
      Response response = await _dio.get('/$kitchenId', queryParameters: {
        'PageNumber': '1',
        'PageSize': '10',
        // 'OrderBy': 'createdDate:desc',
      });
      Logger().i('data: ' + response.data);
      List<dynamic> MealsData = response.data as List<dynamic>;

      List<MealDetailResponse> Meals =
          MealsData.map((data) => MealDetailResponse.fromJson(data)).toList();
      return Meals;
    } catch (error) {
      Logger().e("Error creating Dish: $error");
      throw error;
    }
  }

  //edit kitchen
  Future<void> editKitchen(String kitchenId, KitchenRequest kitchen) async {
    try {
      Response response =
          await _dio.put('/$kitchenId', data: kitchen.toRawJson());
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
