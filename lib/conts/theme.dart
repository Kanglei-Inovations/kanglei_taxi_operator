import 'package:flutter/material.dart';

import 'package:kanglei_taxi_operator/conts/firebase/color_constants.dart';
import 'package:kanglei_taxi_operator/conts/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    backgroundColor: AppColors.white,
    textTheme: TTextTheme.lightTextTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: AppColors.spaceCadet,
    textTheme: TTextTheme.darkTextTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.indyBlue,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}
