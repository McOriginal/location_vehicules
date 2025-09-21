import 'package:flutter/material.dart';

class AppTheme {
  static const primary = Color(0xFF0A253F); // Bleu profond
  static const accent = Color(0xFF00BFA6); // Vert menthe
  static const background = Color(0xFFF7F9FC); // Fond léger

  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: accent,
    ),
    scaffoldBackgroundColor: background,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      elevation: 1,
      iconTheme: IconThemeData(color: primary),
      titleTextStyle:
          TextStyle(color: primary, fontSize: 18, fontWeight: FontWeight.bold),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
