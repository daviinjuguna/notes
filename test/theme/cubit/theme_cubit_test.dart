import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes/theme/theme.dart';

import '../../helpers/hydrated_bloc.dart';

void main() {
  initHydratedStorage();

  group('ThemeCubit', () {
    test('initial state should be defaultTheme', () {
      expect(ThemeCubit().state, equals(ThemeState.system));
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        final themeCubit = ThemeCubit();
        expect(
          themeCubit.fromJson(themeCubit.toJson(themeCubit.state)),
          themeCubit.state,
        );
      });
    });

    blocTest<ThemeCubit, ThemeState>(
      'emits themeState when theme is set',
      build: ThemeCubit.new,
      act: (cubit) => cubit.theme = ThemeState.dark,
      expect: () => [ThemeState.dark],
    );

    blocTest<ThemeCubit, ThemeState>(
      'emits correct light theme when set',
      build: ThemeCubit.new,
      act: (cubit) => cubit.theme = ThemeState.light,
      expect: () => [ThemeState.light],
    );

    blocTest<ThemeCubit, ThemeState>(
      'emits correct system theme when set',
      build: ThemeCubit.new,
      act: (cubit) => cubit.theme = ThemeState.system,
      expect: () => [ThemeState.system],
    );
  });
}
