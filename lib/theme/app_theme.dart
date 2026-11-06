import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF4361EE);
  static const Color accentPurple = Color(0xFF7209B7);
  static const Color vibrantCoral = Color(0xFFFF5964);
  static const Color sunnyYellow = Color(0xFFFFB703);
  static const Color mintGreen = Color(0xFF06D6A0);
  static const Color backgroundLight = Color(0xFFF8F9FE);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundLight,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        primary: primaryBlue,
        secondary: accentPurple,
        tertiary: sunnyYellow,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Color(0xFF1F2937),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Color(0xFF1F2937)),
      ),
    );
  }
}
