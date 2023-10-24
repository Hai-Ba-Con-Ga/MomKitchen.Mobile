import '../data/dish_api.dart';
import '../model/dish_model.dart';

class DishRepository {
  final DishApi _dishApi;
  DishRepository({required DishApi dishApi}) : _dishApi = dishApi;
  Future<void> createDish(Dish dish) {
    return _dishApi.createDish(dish);
  }

  Future<List<Dish>> getAllDishes() {
    return _dishApi.getAllDishes();
  }

  Future<Dish> getDishById(String dishId) {
    return _dishApi.getDishById(dishId);
  }

  Future<void> updateDish(String dishId, DishUpdateRequest dishRequest) {
    return _dishApi.updateDish(dishId, dishRequest);
  }

  Future<void> deleteDish(String dishId) {
    return _dishApi.deleteDish(dishId);
  }
}
