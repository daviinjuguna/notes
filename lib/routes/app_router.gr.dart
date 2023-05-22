// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthPage(),
      );
    },
    HomeDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<HomeDetailsRouteArgs>(
          orElse: () => HomeDetailsRouteArgs(
                  noteId: pathParams.getString(
                'id',
                'create',
              )));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomeDetailsPage(
          key: args.key,
          noteId: args.noteId,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeEmptyRoute(),
      );
    },
    HomeListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
  };
}

/// generated route for
/// [AuthPage]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeDetailsPage]
class HomeDetailsRoute extends PageRouteInfo<HomeDetailsRouteArgs> {
  HomeDetailsRoute({
    Key? key,
    String noteId = 'create',
    List<PageRouteInfo>? children,
  }) : super(
          HomeDetailsRoute.name,
          args: HomeDetailsRouteArgs(
            key: key,
            noteId: noteId,
          ),
          rawPathParams: {'id': noteId},
          initialChildren: children,
        );

  static const String name = 'HomeDetailsRoute';

  static const PageInfo<HomeDetailsRouteArgs> page =
      PageInfo<HomeDetailsRouteArgs>(name);
}

class HomeDetailsRouteArgs {
  const HomeDetailsRouteArgs({
    this.key,
    this.noteId = 'create',
  });

  final Key? key;

  final String noteId;

  @override
  String toString() {
    return 'HomeDetailsRouteArgs{key: $key, noteId: $noteId}';
  }
}

/// generated route for
/// [HomeEmptyRoute]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class HomeListRoute extends PageRouteInfo<void> {
  const HomeListRoute({List<PageRouteInfo>? children})
      : super(
          HomeListRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
