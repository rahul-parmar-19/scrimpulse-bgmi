import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class EsportsTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.neonYellow,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.neonYellow,
        secondary: AppColors.neonCyan,
        surface: AppColors.surface,
        error: AppColors.neonRed,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: AppColors.textPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.rajdhani(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
          color: AppColors.textPrimary,
        ),
        iconTheme: const IconThemeData(color: AppColors.neonYellow),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.surfaceBorder, width: 1),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.rajdhani(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
          letterSpacing: 1.5,
        ),
        displayMedium: GoogleFonts.rajdhani(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.neonYellow,
          letterSpacing: 1.2,
        ),
        headlineSmall: GoogleFonts.rajdhani(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: 1.0,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.textMuted,
        ),
        labelLarge: GoogleFonts.rajdhani(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.0,
          color: Colors.black,
        ),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.neonYellow,
        unselectedLabelColor: AppColors.textMuted,
        indicatorColor: AppColors.neonYellow,
        labelStyle: GoogleFonts.rajdhani(
          fontSize: 15,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.1,
        ),
        unselectedLabelStyle: GoogleFonts.rajdhani(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.neonYellow,
        unselectedItemColor: AppColors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
