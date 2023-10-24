import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../model/dish_model.dart';
import '../utils/constants.dart';

class DishApi {
  final Dio _dio = Dio();
  DishApi() {
    _dio.options.baseUrl = '${AppConstants.domainAddress}/dish';
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
      Response response = await _dio.get('');
      List<dynamic> dishData = response.data as List<dynamic>;
      List<Dish> dishes = dishData.map((data) => Dish.fromJson(data)).toList();
      return dishes;
    } catch (error) {
      Logger().e("Error fetching dishes: $error");
      throw error;
    }
  }

  Future<void> updateDish(String dishId, DishUpdateRequest dishRequest) async {
    try {
      Response response = await _dio.put('/$dishId', data: dishRequest.toRawJson());
      Logger().i(response.data);
    } catch (error) {
      Logger().e("Error updating dish: $error");
      throw error;
    }
  }

  Future<void> deleteDish(String dishId) async {
    try {
      Response response = await _dio.delete('/$dishId');
      Logger().i(response.data);
    } catch (error) {
      Logger().e("Error deleting dish: $error");
      throw error;
    }
  }

  Future<Dish> getDishById(String dishId) async {
    try {
      Response response = await _dio.get('/$dishId');
      Map<String, dynamic> dishData = response.data as Map<String, dynamic>;
      Dish dish = Dish.fromJson(dishData);
      return dish;
    } catch (error) {
      Logger().e("Error fetching dish by ID: $error");
      throw error;
    }
  }
}
