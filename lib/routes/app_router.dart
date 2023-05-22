// coverage:ignore-file

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notes/auth/auth.dart';
import 'package:notes/home/home.dart';
import 'package:notes/splash/splash.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  AppRouter(GlobalKey<NavigatorState> navKey) : super(navigatorKey: navKey);

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: AuthRoute.page),
        AutoRoute(
          page: HomeRoute.page,
          children: [
            AutoRoute(page: HomeListRoute.page, path: ''),
            AutoRoute(page: HomeDetailsRoute.page, path: ':id'),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
      ];
}
