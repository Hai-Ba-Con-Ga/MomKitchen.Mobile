import '../data/meal_api.dart';
import '../model/meal_detail_model.dart';
import '../model/meal_model.dart';

class MealRepository {
  final MealApi _mealApi;
  MealRepository({required MealApi mealApi}) : _mealApi = mealApi;
  Future<void> createMeal(MealCreateRequest meal) {
    return _mealApi.createMeal(meal);
  }

  Future<List<MealGetAllResponse>> getAllMeales() {
    return _mealApi.getAllMeales();
  }

  Future<MealDetailResponse> getMealById(String mealId) {
    return _mealApi.getMealById(mealId);
  }

  // Future<void> updateMeal(String mealId, Meal mealRequest) {
  //   return _mealApi.updateMeal(mealId, mealRequest);
  // }

  Future<void> deleteMeal(String mealId) {
    return _mealApi.deleteMeal(mealId);
  }
}
