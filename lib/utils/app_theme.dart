import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor: AppColors.darkBackground,

    cardColor: const Color(0xFF111827),

    colorScheme: ColorScheme.dark(primary: AppColors.primary),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      elevation: 0,
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(AppColors.primary),
      trackColor: WidgetStateProperty.all(AppColors.primary.withOpacity(0.5)),
    ),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    scaffoldBackgroundColor: AppColors.lightBackground,

    cardColor: Colors.white,

    colorScheme: ColorScheme.light(primary: AppColors.primary),

    appBarTheme: const AppBarTheme(backgroundColor: Colors.white, elevation: 0),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(AppColors.primary),
      trackColor: WidgetStateProperty.all(AppColors.primary.withOpacity(0.5)),
    ),
  );
}
