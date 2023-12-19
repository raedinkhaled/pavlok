import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
      useMaterial3: true,
      primaryColor: const Color(0xFFF925CFF),
      primaryColorDark: const Color(0xfff5f12fc),
      primaryColorLight: const Color(0xfffcbb2ff),
      scaffoldBackgroundColor: Colors.white,
      cardColor: const Color(0xFFFFFF4EB),
      fontFamily: 'Rubik',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: Color(0xfff040710),
          fontWeight: FontWeight.w700,
          fontSize: 36,
        ),
        displayMedium: TextStyle(
          color: Color(0xfff040710),
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),
        displaySmall: TextStyle(
          color: Color(0xfff040710),
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
        bodyLarge: TextStyle(
          color: Color(0xfff040710),
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
        bodyMedium: TextStyle(
          color: Color(0xfff040710),
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        bodySmall: TextStyle(
          color: Color(0xfff040710),
          fontWeight: FontWeight.normal,
          fontSize: 10,
        ),
      ));
}
