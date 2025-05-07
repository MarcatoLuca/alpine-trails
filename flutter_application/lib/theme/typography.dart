import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var myTextTheme = GoogleFonts.sarabunTextTheme(typography).copyWith(
  displayLarge: GoogleFonts.underdog(textStyle: typography.displayLarge),
  displayMedium: GoogleFonts.underdog(textStyle: typography.displayMedium),
  displaySmall: GoogleFonts.underdog(textStyle: typography.displaySmall),
  headlineLarge: GoogleFonts.underdog(textStyle: typography.headlineLarge),
  headlineMedium: GoogleFonts.underdog(textStyle: typography.headlineMedium),
  headlineSmall: GoogleFonts.underdog(textStyle: typography.headlineSmall),
);

const typography = TextTheme(
  displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: Colors.brown),
  displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.brown),
  displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.brown),
  headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.normal),
  headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.normal),
  headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
  labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
  labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
  labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
  bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
  bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
  bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
);
