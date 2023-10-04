import 'package:go_router/go_router.dart';

import '../view/page/sign_up_page.dart';
import '../view/page/login_page.dart';
import 'router_key_management.dart';

class AppPath {
  static const String login = '/login';
  static const String signUp = '/signUp';
}

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppPath.login,
    navigatorKey: RouterKeyManager.instance.rootNavigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: AppPath.login,
        builder: (
          context,
          state,
        ) =>
            const LoginPage(),
      ),
      GoRoute(
        path: AppPath.signUp,
        builder: (
          context,
          state,
        ) =>
            const SignUpPage(),
      ),
    ],
    debugLogDiagnostics: true,
  );
}
