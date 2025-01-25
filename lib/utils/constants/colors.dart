import 'package:flutter/material.dart';

class KColors {
  KColors._();

  // App Main Colors
  static const Color primary = Color(0xFF6750a4);
  static const Color secondary = Color(0xFF625b71);
  static const Color accent = Color(0xFF9a82db);

  //Gradient Colors
  static const Gradient linerGradient = LinearGradient(
      begin: Alignment(0.0, 0.0),
      end: Alignment(0.707, -0.707),
      colors: [
        Color(0xFFf2b8b5),
        Color(0xFFf9dedc),
        Color(0xFFfceeee),
      ]);

  //Text Colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textWhite = Colors.white;

  //Background Colors
  static const Color light = Color(0xFFfffbfe);
  static const Color dark = Color(0xFF141218);
  static const Color primaryBackground = Color(0xFFfef7ff);

  //Background Container Colors
  static const Color lightContainer = Color(0xFFeaddff);
  static const Color darkContainer = Color(0xFF4f378b);

  //Button Colors
  static const Color buttonPrimary = Color(0xFF6750a4);
  static const Color buttonSecondary = Color(0xFFe8def8);
  static Color buttonDisabled = KColors.white.withOpacity(0.12);

  //Border Colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  //Error and Validation Colors
  static const Color error = Color(0xFFb3261e);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

  //Nautral Shades
  static const Color black = Color(0xFF000000);
  static const Color darkerGrey = Color(0xFF1d1b20);
  static const Color darkGrey = Color(0xFF322f35);
  static const Color grey = Color(0xFF48464c);
  static const Color softGrey = Color(0xFFe6e0e9);
  static const Color lightGrey = Color(0xFFf5eff7);
  static const Color white = Color(0xFFFFFFFF);
}
