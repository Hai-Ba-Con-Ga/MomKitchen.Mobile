import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../model/dish_model.dart';
import '../utils/constants.dart';

class DishApi {
  final Dio _dio = Dio();
  DishApi() {
    _dio.options.baseUrl = '${AppConstants.localhostAdress}/dish';
    _dio.options.contentType = Headers.jsonContentType;
    _dio.options.responseType = ResponseType.json;
  }

  Future<void> createDish(Dish dishRequest) async {
    try {
      Logger().i(dishRequest.toRawJson());
      Response response = await _dio.post('', data: dishRequest);
      Logger().i(response.data);
    } catch (error) {
      Logger().e("Error creating dish: $error");
      throw error;
    }
  }

  Future<List<Dish>> getAllDishes() async {
    try {
      // add fields to get
      Response response = await _dio.get('', queryParameters: {'fields': 'UpdatedDate:desc'});
      List<dynamic> dishData = response.data['data'] as List<dynamic>;
      List<Dish> dishes = dishData.map((data) => Dish.fromJson(data)).toList();
      return dishes;
    } catch (error) {
      Logger().e("Error fetching dishes: $error");
      throw error;
    }
  }

  Future<void> updateDish(String dishId, DishUpdateRequest dishRequest) async {
    try {
      Response response = await _dio.put('', queryParameters: {'dishId': dishId}, data: dishRequest.toRawJson());
      Logger().i(response.data);
    } catch (error) {
      Logger().e("Error updating dish: $error");
      throw error;
    }
  }

  Future<void> deleteDish(String dishId) async {
    try {
      Logger().i(dishId);
      Response response = await _dio.delete('', queryParameters: {'dishId': dishId});
      Logger().i(response.data);
    } catch (error) {
      Logger().e("Error deleting dish: $error");
      throw error;
    }
  }

  Future<Dish> getDishById(String dishId) async {
    try {
      Response response = await _dio.get('', queryParameters: {'dishId': dishId});
      Map<String, dynamic> dishData = response.data as Map<String, dynamic>;
      Dish dish = Dish.fromJson(dishData);
      return dish;
    } catch (error) {
      Logger().e("Error fetching dish by ID: $error");
      throw error;
    }
  }
}
