import 'package:flutter/material.dart';

class AppColors {
  static const sTierColor = Color.fromARGB(255, 248, 89, 79);
  static const aTierColor = Color.fromARGB(255, 255, 145, 77);
  static const bTierColor = Color.fromARGB(255, 255, 189, 89);
  static const cTierColor = Color.fromARGB(255, 255, 222, 89);
  static const dTierColor = Color.fromARGB(255, 193, 255, 114);
  static const whiteColor = Color.fromARGB(255, 255, 251, 232);
}

extension CustomTheme on ThemeData {
  Color get sTier => AppColors.sTierColor;
  Color get aTier => AppColors.aTierColor;
  Color get bTier => AppColors.bTierColor;
  Color get cTier => AppColors.cTierColor;
  Color get dTier => AppColors.dTierColor;
  Color get white => AppColors.whiteColor;
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: AppColors.cTierColor,
          fontFamily: "Coffee Crafts",
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: AppColors.bTierColor,
          fontFamily: "Coffee Crafts",
        ),
        headlineSmall: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: AppColors.aTierColor,
          fontFamily: "Coffee Crafts",
        ),
      ),
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: const Color.fromARGB(255, 33, 33, 33),
      primaryColorDark: const Color.fromARGB(255, 25, 25, 25),
      appBarTheme: const AppBarTheme(
        foregroundColor: Color(0xFF272727),
        backgroundColor: Color(0xFF272727),
        elevation: 10,
      ),
    );
  }
}
