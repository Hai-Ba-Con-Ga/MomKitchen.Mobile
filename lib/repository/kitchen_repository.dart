import '../data/kitchen_api.dart';
import '../model/kitchen_model.dart';
import '../model/meal_detail_model.dart';

class KitchenRepository {
  final KitchenApi _kitchenApi;
  KitchenRepository({required KitchenApi kitchenApi})
      : _kitchenApi = kitchenApi;
  Future<void> CreateKitchen(KitchenRequest kitchenRequest) {
    return _kitchenApi.createKitchen(kitchenRequest);
  }

  Future<void> EditKitchen(String kitchenId, KitchenRequest kitchenRequest) {
    return _kitchenApi.editKitchen(kitchenId, kitchenRequest);
  }

  Future<Kitchen> GetKitchen(String kitchenId) {
    return _kitchenApi.getKitchen(kitchenId);
  }

  Future<List<Kitchen>> getAllKitchens() {
    return _kitchenApi.getAllKitchens();
  }

  Future<List<MealDetailResponse>> getAllMealKitchens(String kitchenId) {
    return _kitchenApi.getAllMealKitchens(kitchenId);
  }
}
