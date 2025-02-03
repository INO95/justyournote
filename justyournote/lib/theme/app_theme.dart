// 앱 테마 설정 집중화
import 'package:flutter/material.dart';

class AppTheme {
  // ThemeData는 앱의 테마를 정의하는 클래스이다.
  // copyWith는 ThemeData의 속성을 복사하여 새로운 ThemeData를 생성하는 메서드이다.
  // 이를 사용하면 기존의 ThemeData를 변경하지 않고 새로운 ThemeData를 생성할 수 있다.
  static final ThemeData vintageTheme = ThemeData().copyWith(
    // ColorScheme는 앱의 색상을 정의하는 클래스이다.
    // fromSeed는 ColorScheme를 생성하는 메서드이다.
    // seedColor은 색상의 기준이 되는 색상이다.
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF8B7355),
      brightness: Brightness.light,
    ).copyWith(
      // surface는 화면의 배경색을 정의하는 속성이다.
      surface: const Color(0xFFF5F0E6),
    ),
    textTheme: _vintageTextTheme,
    appBarTheme: _appBarTheme,
    scaffoldBackgroundColor: const Color(0xFFF5F0E6),
  );

  static const TextTheme _vintageTextTheme = TextTheme(
    // bodyMedium은 본문 텍스트의 스타일을 정의하는 속성이다.
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
