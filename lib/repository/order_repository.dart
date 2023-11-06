import '../data/order_api.dart';
import '../model/order_model.dart';

class OrderRepository {
  final OrderApi _orderApi;
  OrderRepository({required OrderApi orderApi}) : _orderApi = orderApi;

  // Future<void> createMeal(MealCreateRequest meal) {
  //   return _mealApi.createMeal(meal);
  // }

  Future<List<Order>> getAllOrderByUserId() {
    return _orderApi.getAllOrderByUserId();
  }

  Future<Order> getOrderById(String mealId) {
    return _orderApi.getOrderById(mealId);
  }

  // Future<void> updateMeal(String mealId, Meal mealRequest) {
  //   return _mealApi.updateMeal(mealId, mealRequest);
  // }

  // Future<void> deleteMeal(String mealId) {
  //   return _mealApi.deleteMeal(mealId);
  // }
}
