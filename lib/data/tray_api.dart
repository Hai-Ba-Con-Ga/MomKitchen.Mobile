import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../model/tray_model.dart';
import '../utils/constants.dart';

class TrayApi {
  final Dio _dio = Dio();
  TrayApi() {
    _dio.options.baseUrl = '${AppConstants.localhostAdress}/Tray';
    _dio.options.contentType = Headers.jsonContentType;
    _dio.options.responseType = ResponseType.json;
  }

  Future<void> createTray(TrayCreateRequest trayRequest) async {
    try {
      Logger().i(trayRequest.toRawJson());
      Response response = await _dio.post('', data: trayRequest);
      Logger().i(response.data);
    } catch (error) {
      Logger().e("Error creating Dish: $error");
      throw error;
    }
  }

  Future<List<Tray>> getAllTrayes() async {
    try {
      // add fields to get
      Response response = await _dio.get('', queryParameters: {'fields': 'UpdatedDate:desc'});
      List<dynamic> DishData = response.data['data'] as List<dynamic>;
      List<Tray> Dishes = DishData.map((data) => Tray.fromJson(data)).toList();
      return Dishes;
    } catch (error) {
      Logger().e("Error fetching Dishes: $error");
      throw error;
    }
  }

  Future<void> updateTray(String DishId, Tray DishRequest) async {
    try {
      Response response = await _dio.put('', queryParameters: {'DishId': DishId}, data: DishRequest.toRawJson());
      Logger().i(response.data);
    } catch (error) {
      Logger().e("Error updating Dish: $error");
      throw error;
    }
  }

  Future<void> deleteTray(String DishId) async {
    try {
      Logger().i(DishId);
      Response response = await _dio.delete('', queryParameters: {'DishId': DishId});
      Logger().i(response.data);
    } catch (error) {
      Logger().e("Error deleting Dish: $error");
      throw error;
    }
  }

  Future<Tray> getTrayById(String DishId) async {
    try {
      Response response = await _dio.get('', queryParameters: {'DishId': DishId});
      Map<String, dynamic> DishData = response.data as Map<String, dynamic>;
      Tray Dish = Tray.fromJson(DishData);
      return Dish;
    } catch (error) {
      Logger().e("Error fetching Dish by ID: $error");
      throw error;
    }
  }
}
