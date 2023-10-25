import 'package:logger/logger.dart';

import '../../model/dish_model.dart';
import '../../repository/dish_repository.dart';
import '../base_cubit.dart';
import '../base_state.dart';

class DishBloc extends BaseCubit {
  DishBloc(this._dishRepository) : super(InitialState());
  final DishRepository _dishRepository;
  void init() {}
  Future<void> getDish() async {
    try {
      emit(
        CommonState(
          null,
          isLoading: true,
        ),
      );
      final dish = await _dishRepository.getAllDishes();
      Logger().i("dish length ${dish.length}");
      emit(
        CommonState<List<Dish>>(
          dish,
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

  Future<void> deleteDish(String dishId) async {
    try {
      emit(
        CommonState(
          null,
          isLoading: true,
        ),
      );
      await _dishRepository.deleteDish(dishId);
      Logger().i("Dish with ID $dishId deleted successfully");
      await getDish();
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

  Future<void> reload() async {
    try {
      emit(
        CommonState(
          null,
          isLoading: true,
        ),
      );
      // sleep 0.1s;
      await getDish();
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
