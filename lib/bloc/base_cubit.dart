import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_state.dart';

abstract class BaseCubit extends Cubit<BaseState> {
  bool isUpdate = false;

  final dio = Dio();

  BaseCubit(BaseState state) : super(state);

  CommonState? get latestLoadedState {
    if (state is CommonState) {
      return state as CommonState;
    }
    return null;
  }
}
