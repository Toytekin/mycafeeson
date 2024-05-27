import 'package:flutter/material.dart';

class CoffeeAppColors {
  static const Color darkBrown = Color(0xFF4B2E39);
  static const Color mediumBrown = Color(0xFF6F4E37);
  static const Color lightBrown = Color(0xFFB28D67);
  static const Color beige = Color(0xFFF0E0D6);
  static const Color cream = Color(0xFFFFFDD0);
  static const Color milk = Color(0xFFFAF0E6);
  static const Color white = Color(0xFFFFFFFF);
  static const Color darkGreen = Color(0xFF2E8B57);
  static const Color terracotta = Color(0xFFE2725B);
}

class CoffeeAppTheme {
  static final ThemeData themeData = ThemeData(
    primaryColor: CoffeeAppColors.mediumBrown,
    scaffoldBackgroundColor: CoffeeAppColors.beige,
    buttonTheme: const ButtonThemeData(
      buttonColor: CoffeeAppColors.lightBrown,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: CoffeeAppColors.mediumBrown,
        iconColor: CoffeeAppColors.beige,
        textStyle: const TextStyle(
          color: CoffeeAppColors.beige,
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: CoffeeAppColors.beige,
      iconTheme: IconThemeData(color: CoffeeAppColors.white),
    ),
  );
}
