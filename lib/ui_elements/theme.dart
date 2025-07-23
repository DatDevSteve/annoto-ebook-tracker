import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final themeData = ThemeData(
  scaffoldBackgroundColor: Colors.black,

  textTheme: TextTheme(
    //For Buttons:
    labelLarge: GoogleFonts.inriaSans(color: Colors.white),
    //For Headings:
    headlineMedium: GoogleFonts.inriaSans(
      color: Colors.white,
      fontSize: 20,
      letterSpacing: 5,
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: GoogleFonts.inriaSans(
      color: Colors.white,
      fontSize: 30,
      letterSpacing: 10,
      fontWeight: FontWeight.bold,
    ),
    //Body:
    bodyLarge: GoogleFonts.inriaSans(color: Colors.white, fontSize: 30),
    bodyMedium: GoogleFonts.inriaSans(color: Colors.white, fontSize: 24),
    bodySmall: GoogleFonts.inriaSans(color: Colors.white, fontSize: 16),
  ),
  cardTheme: CardThemeData(color: Color.fromRGBO(16, 19, 24, 1), elevation: 10),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[200],
    helperStyle: GoogleFonts.inriaSans(fontSize: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: Color.fromRGBO(7, 113, 55, 1), width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: Color.fromRGBO(7, 113, 55, 1), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: Colors.red),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    hintStyle: TextStyle(color: Colors.grey[600]),
    labelStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: Color.fromRGBO(7, 113, 55, 1),
      foregroundColor: Colors.white,
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Color.fromRGBO(7, 113, 55, 1),
    actionTextColor: Colors.white,
    contentTextStyle: GoogleFonts.inriaSans(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
);
