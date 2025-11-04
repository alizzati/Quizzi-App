import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF3E2BCE),
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: const Color(0xFF3E2BCE),
    secondary: const Color(0xFF7C4DFF),
  ),
  textTheme: const TextTheme(
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: Color(0xFF3E2BCE),
    ),
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(fontSize: 16),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    filled: true,
    fillColor: Colors.grey[100],
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF3E2BCE),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      minimumSize: const Size(double.infinity, 48),
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
);
