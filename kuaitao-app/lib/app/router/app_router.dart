import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/login_page.dart';
import '../../features/auth/register_page.dart';
import '../../features/detail/thunder_detail_page.dart';
import '../../features/home/home_page.dart';
import '../../features/profile/profile_page.dart';
import '../../features/publish/publish_page.dart';
import '../../features/splash/splash_page.dart';

class AppRoutes {
  AppRoutes._();
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const publish = '/publish';
  static const profile = '/profile';
  static String thunderDetail(String id) => '/thunder/$id';
}

GoRouter buildAppRouter() {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splash,
        builder: (BuildContext context, GoRouterState state) =>
            const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (BuildContext context, GoRouterState state) =>
            const RegisterPage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (BuildContext context, GoRouterState state) =>
            const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.publish,
        builder: (BuildContext context, GoRouterState state) =>
            const PublishPage(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (BuildContext context, GoRouterState state) =>
            const ProfilePage(),
      ),
      GoRoute(
        path: '/thunder/:id',
        builder: (BuildContext context, GoRouterState state) {
          final String id = state.pathParameters['id'] ?? '';
          return ThunderDetailPage(thunderId: id);
        },
      ),
    ],
  );
}
