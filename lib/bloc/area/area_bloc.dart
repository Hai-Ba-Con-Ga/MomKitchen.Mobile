import '../../model/area_model.dart';
import '../../repository/area_repository.dart';
import '../base_cubit.dart';
import '../base_state.dart';

class AreaBloc extends BaseCubit {
  AreaBloc(this._areaRepository) : super(InitialState());
  final AreaRepository _areaRepository;
  void init() {}
  Future<void> getArea() async {
    try {
      emit(
        CommonState(
          null,
          isLoading: true,
        ),
      );
      final area = await _areaRepository.getAll();
      print("day ${area.length}");
      emit(
        CommonState<List<Area>>(
          area,
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
