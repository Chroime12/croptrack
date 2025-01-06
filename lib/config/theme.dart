import 'package:croptrack/config/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData().copyWith(
  colorScheme: lColorScheme,
  textTheme: TextTheme(
    titleLarge: GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.2,
      color: lColorScheme.onPrimary,
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.2,
      color: lColorScheme.onPrimary,
    ),
    titleSmall: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.2,
      color: lColorScheme.onPrimary,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.2,
      color: lColorScheme.secondary,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.2,
      color: lColorScheme.secondary,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.2,
      color: lColorScheme.secondary,
    ),
  ),
);
