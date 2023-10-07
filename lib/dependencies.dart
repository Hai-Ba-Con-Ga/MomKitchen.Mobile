import 'package:get_it/get_it.dart';

import 'bloc/auth/auth_bloc.dart';

class AppDependencies {
  AppDependencies._();
  static GetIt get injector => GetIt.I;

  static Future initialize() async {
    injector.registerSingleton<AuthBloc>(
      AuthBloc(),
    );
  }
}
