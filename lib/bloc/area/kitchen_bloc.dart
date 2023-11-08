import 'package:logger/logger.dart';

import '../../model/kitchen_model.dart';
import '../../model/meal_detail_model.dart';
import '../../repository/kitchen_repository.dart';
import '../base_cubit.dart';
import '../base_state.dart';

class KitchenBloc extends BaseCubit {
  KitchenBloc(this._kitchenRepository) : super(InitialState());
  final KitchenRepository _kitchenRepository;
  void init() {}
  Future<void> getAllKitchens() async {
    try {
      emit(
        CommonState(
          null,
          isLoading: true,
        ),
      );
      final kitchens = await _kitchenRepository.getAllKitchens();
      Logger().i('kitchens length ${kitchens.length}');
      emit(
        CommonState<List<Kitchen>>(
          kitchens,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        CommonState(
          null,
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> getAllMealKitchens(String kitchenId) async {
    try {
      emit(
        CommonState(
          null,
          isLoading: true,
        ),
      );
      final kitchens = await _kitchenRepository.getAllMealKitchens(kitchenId);
      Logger().i('kitchens length ${kitchens.length}');
      emit(
        CommonState<List<MealDetailResponse>>(
          kitchens,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        CommonState(
          null,
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
