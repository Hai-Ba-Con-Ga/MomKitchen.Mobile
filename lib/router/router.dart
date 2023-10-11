import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../view/page/SC005_kitchen_map_page.dart';
import '../view/page/SC006_search_page.dart';
import '../view/page/SC013_order_detail_page.dart';
import '../view/page/SC015_notification_page.dart';
import '../view/page/home_page.dart';
import '../view/page/sign_up_page.dart';
import '../view/page/SC001_login_page.dart';
import '../view/page/user_page.dart';
import '../view/widgets/base_scaffold.dart';
import 'router_key_management.dart';

class AppPath {
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String home = '/home';
  static const String favorite = '/favorite';
  static const String notification = '/notification';
  static const String user = '/user';
  static const String kitchenmap = '/kitchenmap';
  static const String orderdetail = '/orderdetail';
  static const String search = '/search';
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
                const NotificationPage(),
          ),
          GoRoute(
            path: AppPath.user,
            builder: (
              context,
              state,
            ) =>
                const UserPage(),
          ),
          GoRoute(
              path: AppPath.kitchenmap,
              builder: (
                context,
                state,
              ) =>
                  const KitchenMapPage()),
        ],
      ),
      GoRoute(
          path: AppPath.orderdetail,
          builder: (context, state) => const OrderDetailPage()),
      GoRoute(
          path: AppPath.search,
          builder: (context, state) => const SearchPage()),
    ],
    debugLogDiagnostics: true,
  );
}
