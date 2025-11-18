import 'package:akurasipupuk/core/config/elevated_icon_button_theme.dart';
import 'package:flutter/material.dart';

class AgricultureTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,

    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),

    // ---------------------------------------------------------
    // 🌿 Color Scheme — Hijau Pertanian
    // ---------------------------------------------------------
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF3C8D40), // hijau daun
      primary: const Color(0xFF3C8D40),
      secondary: const Color(0xFF6BBF59), // hijau muda
      tertiary: const Color(0xFF8DCC70),
    ),

    // ---------------------------------------------------------
    // 🌿 Text Theme
    // ---------------------------------------------------------
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2E5E2A),
      ),
      headlineMedium: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: Color(0xFF2E5E2A),
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Color(0xFF334833),
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Color(0xFF556B55),
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Color(0xFF3C8D40),
      ),
    ),

    // ---------------------------------------------------------
    // 🌿 AppBar Theme
    // ---------------------------------------------------------
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF3C8D40),
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 1,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),

    // ---------------------------------------------------------
    // 🌿 Elevated Button Theme
    // ---------------------------------------------------------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3C8D40),
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
    ),

    // ---------------------------------------------------------
    // 🌿 Icon Button Theme (tanpa background)
    // ---------------------------------------------------------
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: const Color(0xFF3C8D40),
        padding: const EdgeInsets.all(12),
        iconSize: 26,
      ),
    ),

    // ---------------------------------------------------------
    // 🌿 Elevated Icon Button Theme (Button + Icon)
    // ---------------------------------------------------------
    extensions: <ThemeExtension<dynamic>>[
      ElevatedIconButtonTheme(
        backgroundColor: const Color(0xFF3C8D40),
        foregroundColor: Colors.white,
        radius: 12,
      ),
    ],
  );
}
