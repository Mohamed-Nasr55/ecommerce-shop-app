import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysmallshop/features/theme/app_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeData> {
  static const String prefKey = 'isDarkMode';
  
  ThemeCubit() : super(AppThemes.lightTheme) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(prefKey) ?? false;
    emit(isDark ? AppThemes.darkTheme : AppThemes.lightTheme);
  }

  Future<void> toggleTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(prefKey, isDark);
    emit(isDark ? AppThemes.darkTheme : AppThemes.lightTheme);
  }
}
