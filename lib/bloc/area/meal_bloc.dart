import 'package:logger/logger.dart';

import '../../model/meal_model.dart';
import '../../repository/meal_repository.dart';
import '../base_cubit.dart';
import '../base_state.dart';

class MealBloc extends BaseCubit {
  MealBloc(this._mealRepository) : super(InitialState());
  final MealRepository _mealRepository;
  void init() {}
  Future<void> getMeal() async {
    try {
      emit(
        CommonState(
          null,
          isLoading: true,
        ),
      );
      final meal = await _mealRepository.getAllMeales();
      Logger().i("meal length ${meal.length}");
      emit(
        CommonState<List<MealGetReponse>>(
          meal,
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

  Future<void> deleteMeal(String mealId) async {
    try {
      emit(
        CommonState(
          null,
          isLoading: true,
        ),
      );
      await _mealRepository.deleteMeal(mealId);
      Logger().i("Meal with ID $mealId deleted successfully");
      await getMeal();
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
