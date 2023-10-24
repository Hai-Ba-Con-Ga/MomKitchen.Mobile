import '../data/kitchen_api.dart';
import '../model/kitchen_model.dart';

class KitchenRepository {
  final KitchenApi _kitchenApi;
  KitchenRepository({required KitchenApi kitchenApi}) : _kitchenApi = kitchenApi;
  Future<void> CreateKitchen(KitchenRequest kitchenRequest) {
    return _kitchenApi.createKitchen(kitchenRequest);
  }
}
