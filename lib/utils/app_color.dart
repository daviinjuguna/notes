import 'package:flutter/material.dart';

class AppColor {
  static ColorScheme light = const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff19647e),
    onPrimary: Color(0xffffffff),
    primaryContainer: Color(0xffa1cbcf),
    onPrimaryContainer: Color(0xff0e1111),
    secondary: Color(0xff0093c7),
    onSecondary: Color(0xffffffff),
    secondaryContainer: Color(0xffc3e7ff),
    onSecondaryContainer: Color(0xff101314),
    tertiary: Color(0xfffeb716),
    onTertiary: Color(0xff000000),
    tertiaryContainer: Color(0xffffdea5),
    onTertiaryContainer: Color(0xff14120e),
    error: Color(0xffb00020),
    onError: Color(0xffffffff),
    errorContainer: Color(0xfffcd8df),
    onErrorContainer: Color(0xff141213),
    background: Color(0xfff8fafb),
    onBackground: Color(0xff090909),
    surface: Color(0xfff8fafb),
    onSurface: Color(0xff090909),
    surfaceVariant: Color(0xffe2e6e7),
    onSurfaceVariant: Color(0xff111212),
    outline: Color(0xff7c7c7c),
    outlineVariant: Color(0xffc8c8c8),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xff111313),
    onInverseSurface: Color(0xfff5f5f5),
    inversePrimary: Color(0xffa9dbed),
    surfaceTint: Color(0xff19647e),
  );

  static ColorScheme dark = const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xff82bace),
    onPrimary: Color(0xff0e1214),
    primaryContainer: Color(0xff04666f),
    onPrimaryContainer: Color(0xffe0eff1),
    secondary: Color(0xff243e4d),
    onSecondary: Color(0xfff1f3f5),
    secondaryContainer: Color(0xff426173),
    onSecondaryContainer: Color(0xffeaeff1),
    tertiary: Color(0xffffd682),
    onTertiary: Color(0xff14140e),
    tertiaryContainer: Color(0xff9e7910),
    onTertiaryContainer: Color(0xfff8f2e2),
    error: Color(0xffcf6679),
    onError: Color(0xff140c0d),
    errorContainer: Color(0xffb1384e),
    onErrorContainer: Color(0xfffbe8ec),
    background: Color(0xff16191a),
    onBackground: Color(0xffececed),
    surface: Color(0xff16191a),
    onSurface: Color(0xffececed),
    surfaceVariant: Color(0xff3a3f41),
    onSurfaceVariant: Color(0xffe0e0e1),
    outline: Color(0xff76767d),
    outlineVariant: Color(0xff2c2c2e),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xfff8fbfc),
    onInverseSurface: Color(0xff131313),
    inversePrimary: Color(0xff465e67),
    surfaceTint: Color(0xff82bace),
  );

  static const List<Color> noteColors = [
    Color(0xfffafafa), // canvas
    Color(0xfffa8072), // salmon
    Color(0xfffedc56), // mustard
    Color(0xffd0f0c0), // tea
    Color(0xfffca3b7), // flamingo
    Color(0xff997950), // tortilla
    Color(0xfffffdd0), // cream
  ];
}
