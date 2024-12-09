import 'package:flutter/material.dart';

class AppColors {
  static const sTierColor = Color.fromARGB(255, 248, 89, 79);
  static const aTierColor = Color.fromARGB(255, 255, 145, 77);
  static const bTierColor = Color.fromARGB(255, 255, 189, 89);
  static const cTierColor = Color.fromARGB(255, 255, 222, 89);
  static const dTierColor = Color.fromARGB(255, 193, 255, 114);
  static const eTierColor = Color.fromARGB(255, 18, 104, 252);
  static const fTierColor = Color.fromARGB(255, 126, 0, 216);
  static const whiteColor = Color.fromARGB(255, 220, 220, 220);
  static const blackColor = Color.fromARGB(255, 14, 14, 14);
  static const greyColor = Color.fromARGB(255, 47, 47, 47);
  static const lightGreyColor = Color.fromARGB(255, 165, 165, 165);
  static const itemColor = Color.fromARGB(255, 29, 86, 255);
}

extension CustomTheme on ThemeData {
  Color get sTier => AppColors.sTierColor;
  Color get aTier => AppColors.aTierColor;
  Color get bTier => AppColors.bTierColor;
  Color get cTier => AppColors.cTierColor;
  Color get dTier => AppColors.dTierColor;
  Color get eTier => AppColors.eTierColor;
  Color get fTier => AppColors.fTierColor;
  Color get white => AppColors.whiteColor;
  Color get black => AppColors.blackColor;
  Color get grey => AppColors.greyColor;
  Color get lightGrey => AppColors.lightGreyColor;
  Color get item => AppColors.itemColor;
}

class AppTheme {
  static const String fontName = "Coffee Crafts";
  static ThemeData get theme {
    return ThemeData(
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: AppColors.cTierColor,
          fontFamily: fontName,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: AppColors.bTierColor,
          fontFamily: fontName,
        ),
        headlineSmall: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: AppColors.aTierColor,
          fontFamily: fontName,
        ),
        titleSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: AppColors.lightGreyColor,
          fontFamily: fontName,
        ),
        titleMedium: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: AppColors.whiteColor,
          fontFamily: fontName,
        ),
      ),
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: const Color.fromARGB(255, 33, 33, 33),
      primaryColorDark: const Color.fromARGB(255, 25, 25, 25),
      primaryColorLight: const Color.fromARGB(255, 78, 78, 78),
      appBarTheme: const AppBarTheme(
        foregroundColor: Color(0xFF272727),
        backgroundColor: Color(0xFF272727),
        elevation: 10,
      ),
    );
  }
}
