import 'package:logger/logger.dart';

import '../../model/tray_model.dart';
import '../../repository/tray_repository.dart';
import '../base_cubit.dart';
import '../base_state.dart';

class TrayBloc extends BaseCubit {
  TrayBloc(this._trayRepository) : super(InitialState());
  final TrayRepository _trayRepository;
  void init() {}
  Future<void> getTray() async {
    try {
      emit(
        CommonState(
          null,
          isLoading: true,
        ),
      );
      final tray = await _trayRepository.getAllTrayes();
      Logger().i("tray length ${tray.length}");
      emit(
        CommonState<List<Tray>>(
          tray,
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

  Future<void> deleteTray(String trayId) async {
    try {
      emit(
        CommonState(
          null,
          isLoading: true,
        ),
      );
      await _trayRepository.deleteTray(trayId);
      Logger().i("Tray with ID $trayId deleted successfully");
      await getTray();
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
