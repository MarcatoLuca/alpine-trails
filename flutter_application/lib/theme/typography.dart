import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var myTextTheme = GoogleFonts.sarabunTextTheme(typography).copyWith(
  displayLarge: GoogleFonts.montserrat(textStyle: typography.displayLarge),
  displayMedium: GoogleFonts.montserrat(textStyle: typography.displayMedium),
  displaySmall: GoogleFonts.montserrat(textStyle: typography.displaySmall),
  headlineLarge: GoogleFonts.montserrat(textStyle: typography.headlineLarge),
  headlineMedium: GoogleFonts.montserrat(textStyle: typography.headlineMedium),
  headlineSmall: GoogleFonts.montserrat(textStyle: typography.headlineSmall),
  labelLarge: GoogleFonts.montserrat(textStyle: typography.labelLarge),
  labelMedium: GoogleFonts.montserrat(textStyle: typography.labelMedium),
  labelSmall: GoogleFonts.montserrat(textStyle: typography.labelSmall),
  bodyLarge: GoogleFonts.montserrat(textStyle: typography.bodyLarge),
  bodyMedium: GoogleFonts.montserrat(textStyle: typography.bodyMedium),
  bodySmall: GoogleFonts.montserrat(textStyle: typography.bodySmall),
);

const typography = TextTheme(
  displayLarge: TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.bold,
    color: Colors.brown,
  ),
  displayMedium: TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.bold,
    color: Colors.brown,
  ),
  displaySmall: TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: Colors.brown,
  ),
  headlineLarge: TextStyle(fontSize: 31, fontWeight: FontWeight.normal),
  headlineMedium: TextStyle(fontSize: 27, fontWeight: FontWeight.normal),
  headlineSmall: TextStyle(fontSize: 23, fontWeight: FontWeight.normal),
  labelLarge: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
  labelMedium: TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
  labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
  bodyLarge: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
  bodyMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
  bodySmall: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
);
