import 'package:flutter/material.dart';

/// ScrimPulse High-Contrast Esports Color Palette
/// Designed for OLED deep blacks with glowing Neon accents
class AppColors {
  // Backgrounds
  static const Color background = Color(0xFF090B0E);
  static const Color surface = Color(0xFF13171F);
  static const Color surfaceElevated = Color(0xFF1C222E);
  static const Color surfaceBorder = Color(0xFF283142);

  // Neon Accents
  static const Color neonYellow = Color(0xFFDFFF00); // BGMI Primary Glow
  static const Color neonCyan = Color(0xFF00F5D4);   // Secondary Highlight
  static const Color neonOrange = Color(0xFFFF6B00); // Air Drop / Live Match Alert
  static const Color neonRed = Color(0xFFFF3366);    // Danger / Zone Alert

  // Esports & Medals
  static const Color goldWWCD = Color(0xFFFFD700);   // Winner Winner Chicken Dinner
  static const Color silverRank = Color(0xFFC0C0C0);
  static const Color bronzeRank = Color(0xFFCD7F32);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9EABB9);
  static const Color textMuted = Color(0xFF5B6878);

  // Map Colors
  static const Color mapErangel = Color(0xFF2E7D32);  // Forest Green
  static const Color mapMiramar = Color(0xFFE65100);  // Desert Sand/Amber
  static const Color mapSanhok = Color(0xFF00897B);   // Tropical Teal
  static const Color mapRondo = Color(0xFF6A1B9A);    // Modern Neon Violet

  // Gradients
  static const LinearGradient liveBadgeGradient = LinearGradient(
    colors: [Color(0xFFFF3366), Color(0xFFFF6B00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardHeaderGradient = LinearGradient(
    colors: [Color(0xFF1C222E), Color(0xFF13171F)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient neonGlowGradient = LinearGradient(
    colors: [neonYellow, neonCyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

