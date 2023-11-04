import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../model/meal_detail_model.dart';
import '../model/meal_model.dart';
import '../utils/constants.dart';

class MealApi {
  final Dio _dio = Dio();
  MealApi() {
    _dio.options.baseUrl = '${AppConstants.localhostAdress}/Meal';
    _dio.options.contentType = Headers.jsonContentType;
    _dio.options.responseType = ResponseType.json;
  }

  Future<void> createMeal(MealCreateRequest mealRequest) async {
    try {
      Logger().i(mealRequest.toRawJson());
      Response response = await _dio.post('', data: mealRequest);
      Logger().i(response.data);
    } catch (error) {
      Logger().e("Error creating Meal: $error");
      throw error;
    }
  }

  Future<List<MealGetAllResponse>> getAllMeales() async {
    try {
      // add fields to get
      Response response =
          await _dio.get('', queryParameters: {'fields': 'UpdatedDate:desc'});
      List<dynamic> MealData = response.data['data'] as List<dynamic>;
      List<MealGetAllResponse> Meales =
          MealData.map((data) => MealGetAllResponse.fromJson(data)).toList();
      return Meales;
    } catch (error) {
      Logger().e("Error fetching Meales: $error");
      throw error;
    }
  }

  // Future<void> updateMeal(String MealId, Meal MealRequest) async {
  //   try {
  //     Response response = await _dio.put('', queryParameters: {'MealId': MealId}, data: MealRequest.toRawJson());
  //     Logger().i(response.data);
  //   } catch (error) {
  //     Logger().e("Error updating Meal: $error");
  //     throw error;
  //   }
  // }

  Future<void> deleteMeal(String MealId) async {
    try {
      Logger().i(MealId);
      Response response =
          await _dio.delete('', queryParameters: {'MealId': MealId});
      Logger().i(response.data);
    } catch (error) {
      Logger().e("Error deleting Meal: $error");
      throw error;
    }
  }

  Future<MealDetailResponse> getMealById(String MealId) async {
    try {
      Response response = await _dio.get('/' + MealId);
      MealDetailResponse Meal =
          MealDetailResponse.fromJson(response.data['data']);
      return Meal;
    } catch (error) {
      Logger().e("Error fetching Meal by ID: $error");
      throw error;
    }
  }
}
