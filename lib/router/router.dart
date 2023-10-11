import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../view/page/home_page.dart';
import '../view/page/sign_up_page.dart';
import '../view/page/SC001_login_page.dart';
import '../view/page/sign_in_phone.dart';
import '../view/page/user_page.dart';
import '../view/widgets/base_scaffold.dart';
import 'router_key_management.dart';

class AppPath {
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String signUpPhone = '/signUpPhone';
  static const String home = '/home';
  static const String favorite = '/favorite';
  static const String notification = '/notification';
  static const String user = '/user';
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
      GoRoute(
        path: AppPath.signUpPhone,
        builder: (
          context,
          state,
        ) =>
            const SignInPhonePage(),
      ),
      ShellRoute(
        navigatorKey: RouterKeyManager.instance.shellNavigatorKey,
        builder: (
          context,
          state,
          child,
        ) =>
            BaseScaffold(
          child: child,
        ),
        routes: [
          GoRoute(
            path: AppPath.home,
            builder: (
              context,
              state,
            ) =>
                const HomePage(),
          ),
          GoRoute(
            path: AppPath.favorite,
            builder: (
              context,
              state,
            ) =>
                const SizedBox(),
          ),
          GoRoute(
            path: AppPath.notification,
            builder: (
              context,
              state,
            ) =>
                const SizedBox(),
          ),
          GoRoute(
            path: AppPath.user,
            builder: (
              context,
              state,
            ) =>
                const UserPage(),
          ),
        ],
      ),
    ],
    debugLogDiagnostics: true,
  );
}
