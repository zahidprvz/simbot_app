import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF373435);
  static const Color secondaryColor = Color(0xFFF58634);

  static final lightTheme = ThemeData(
    primaryColor: primaryColor,
    brightness: Brightness.light,
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: const Color(0xFFEFEFEF),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: primaryColor, fontSize: 20.0, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: primaryColor, fontSize: 16.0),
    ),
    appBarTheme: const AppBarTheme(
      color: primaryColor,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: secondaryColor),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: primaryColor,
      selectedItemColor: secondaryColor,
      unselectedItemColor: Colors.white,
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.grey,
      brightness: Brightness.light,
    ).copyWith(
      secondary: secondaryColor,
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: primaryColor,
    brightness: Brightness.dark,
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: primaryColor,
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: secondaryColor, fontSize: 20.0, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Colors.white, fontSize: 16.0),
    ),
    appBarTheme: const AppBarTheme(
      color: primaryColor,
      titleTextStyle: TextStyle(color: secondaryColor, fontSize: 20.0, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: secondaryColor),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: primaryColor,
      selectedItemColor: secondaryColor,
      unselectedItemColor: Colors.white,
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.grey,
      brightness: Brightness.dark,
    ).copyWith(
      secondary: secondaryColor,
    ),
  );
}
