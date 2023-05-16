import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/di/di.dart';

@Injectable(env: [Env.dev])
class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(defaultTheme);
  static const defaultTheme = ThemeState.system;

  @override
  ThemeState? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }
    final data = int.tryParse(json['value']?.toString() ?? '');
    if (data != null) {
      return ThemeState.values[data];
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(ThemeState? state) {
    if (state == null) {
      return null;
    }
    return {
      'value': state.index,
    };
  }

  ThemeState get theme => state;

  set theme(ThemeState themeState) => emit(themeState);

  /// Returns appropriate theme mode
  ThemeMode get themeMode {
    switch (state) {
      case ThemeState.light:
        return ThemeMode.light;
      case ThemeState.dark:
        return ThemeMode.dark;
      case ThemeState.system:
        return ThemeMode.system;
    }
  }
}

enum ThemeState { light, dark, system }
