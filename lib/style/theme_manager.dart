import 'package:flutter/material.dart';
import 'package:we_works_movie_app/style/colors.dart';
import 'package:we_works_movie_app/style/font_size.dart';

class ThemeManager extends ChangeNotifier {
  ThemeManager({ThemeData? initialThemeData})
      : _themeData = initialThemeData ?? lightTheme;

  ThemeData _themeData;

  ThemeData get themeData => _themeData;

  void updateTheme(ThemeData value) {
    _themeData = value;
    notifyListeners();
  }

  static ThemeData darkTheme =
      ThemeData.light().copyWith(scaffoldBackgroundColor: AppColors.black);

  static ThemeData lightTheme =
      ThemeData.dark().copyWith(scaffoldBackgroundColor: AppColors.white);

  static ThemeData get genericThemeData => ThemeData(
        primaryColor: AppColors.primary,
        appBarTheme: appBarTheme,
      );

  static AppBarTheme get appBarTheme => const AppBarTheme(
        color: AppColors.primary,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.white,
          fontSize: AppFontSize.s18,
          fontWeight: AppFontWeight.bold,
        ),
      );
}
