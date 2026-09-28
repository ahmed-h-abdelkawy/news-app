import 'package:flutter/material.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';

class AppTheme {
  static ThemeData get mainTheme => ThemeData(
    colorScheme: .fromSeed(seedColor: AppColors.primary),
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.grey3,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
