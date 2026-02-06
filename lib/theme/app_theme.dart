//Centralized Theme System

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: Colors.deepPurple,
    scaffoldBackgroundColor: const Color(0xFFF8F7FC),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
    ),

    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
    ),
  );
}