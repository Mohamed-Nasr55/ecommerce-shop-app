import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppThemes {


  // ---------------- TEAL ----------------
  static final ThemeData tealLight = ThemeData(
    primaryColor: AppColors.tealPrimary,
    scaffoldBackgroundColor: AppColors.tealScaffoldLight,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.tealPrimary),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.tealPrimary,
        foregroundColor: AppColors.tealButtonLight,
      ),
    ),
  );

  static final ThemeData tealDark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.tealPrimary,
    scaffoldBackgroundColor: AppColors.tealScaffoldDark,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.tealPrimary),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.tealPrimary,
        foregroundColor: AppColors.tealButtonDark,
      ),
    ),
  );
}
