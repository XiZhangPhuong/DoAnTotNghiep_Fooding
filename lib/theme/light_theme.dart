import 'package:flutter/material.dart';

import '../utils/color_resources.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: ColorResources.BACK_GROUND,
  fontFamily: 'Nunito',
  primaryColor: const Color(0xFF0DAC43),
  brightness: Brightness.light,
  // scaffoldBackgroundColor: ColorResources.BACKGROUND,
  hintColor: const Color(0xFF9E9E9E),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.black.withOpacity(0),
  ), colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: Colors.white,
  ).copyWith(background: ColorResources.BACK_GROUND),
);
