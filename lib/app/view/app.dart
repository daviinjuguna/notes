import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/di/di.dart';
import 'package:notes/l10n/l10n.dart';
import 'package:notes/routes/app_router.dart';
import 'package:notes/splash/splash.dart';
import 'package:notes/theme/theme.dart';
import 'package:notes/utils/app_color.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late final AppRouter _appRouter;

  //bloc
  late final ThemeCubit _themeCubit;
  late final SplashCubit _splashCubit;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(_navigatorKey);

    //bloc
    _themeCubit = getIt<ThemeCubit>();
    _splashCubit = getIt<SplashCubit>();
  }

  @override
  void dispose() {
    _appRouter.dispose();
    _themeCubit.close();
    _splashCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _themeCubit),
        BlocProvider(create: (_) => _splashCubit),
      ],
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          switch (state.status) {
            case SplashStatus.initial:
              break;
            case SplashStatus.authenticated:
              _appRouter.pushAndPopUntil(
                const HomeRoute(),
                predicate: (_) => false,
              );
              break;
            case SplashStatus.unauthenticated:
              _appRouter.pushAndPopUntil(
                const AuthRoute(),
                predicate: (_) => false,
              );
              break;
          }
        },
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              routerDelegate: _appRouter.delegate(),
              routeInformationParser: _appRouter.defaultRouteParser(),
              routeInformationProvider: _appRouter.routeInfoProvider(),
              theme: ThemeData.from(
                colorScheme: AppColor.light,
                useMaterial3: true,
              ).copyWith(
                inputDecorationTheme: _defaultInputTheme(),
              ),
              darkTheme: ThemeData.from(
                colorScheme: AppColor.dark,
                useMaterial3: true,
              ).copyWith(
                inputDecorationTheme: _defaultInputTheme(),
              ),
              themeMode: context.watch<ThemeCubit>().themeMode,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
            );
          },
        ),
      ),
    );
  }
}

InputDecorationTheme _defaultInputTheme() => InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
