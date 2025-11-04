import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF7C4DFF),
  scaffoldBackgroundColor: const Color(0xFF1E1E2C),
  colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
    primary: const Color(0xFF7C4DFF),
    secondary: const Color(0xFFB388FF),
  ),
  textTheme: const TextTheme(
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(fontSize: 16),
  ),
);
