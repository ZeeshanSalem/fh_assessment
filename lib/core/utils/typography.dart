import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTypography {
  static TextTheme lightTheme = TextTheme(
    headlineLarge: GoogleFonts.poppins(
        fontSize: 26, fontWeight: FontWeight.w600, color: CustomColors.primary),
    headlineMedium: GoogleFonts.poppins(
        fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
    headlineSmall: GoogleFonts.poppins(
        fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
    titleLarge: GoogleFonts.poppins(
        fontSize: 22, fontWeight: FontWeight.w600, color: CustomColors.primary),
    titleMedium: GoogleFonts.poppins(
        fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
    titleSmall: GoogleFonts.poppins(
        fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: CustomColors.primary,
    ),
    bodyMedium: GoogleFonts.poppins(
        fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
    bodySmall: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.grey,
    ),
    labelMedium: GoogleFonts.poppins(
        fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
  );
}
