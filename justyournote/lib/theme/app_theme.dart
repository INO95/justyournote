// 앱 테마 설정 집중화
// Centralized app theme configuration
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData vintageTheme = ThemeData().copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF8B7355),
      brightness: Brightness.light,
    ).copyWith(
      surface: const Color(0xFFF5F0E6),
      background: const Color(0xFFF5F0E6),
    ),
    textTheme: _vintageTextTheme,
    appBarTheme: _appBarTheme,
    scaffoldBackgroundColor: const Color(0xFFF5F0E6),
  );

  static const TextTheme _vintageTextTheme = TextTheme(
    bodyMedium: TextStyle(color: Color(0xFF4A3A2D), fontSize: 16),
  );

  static const AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: Color(0xFF6B5B4D),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}
