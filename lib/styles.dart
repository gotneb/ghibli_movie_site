import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomStyle {
  static const primaryColor = Colors.white;
  static final mainColor = Colors.redAccent[700];

  static final movieTitle = GoogleFonts.poppins(
    color: primaryColor,
    fontSize: 22,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  );

  static final normalText = GoogleFonts.poppins(
    color: Colors.grey[300],
    fontSize: 15,
  );

  static final description = GoogleFonts.poppins(
    color: primaryColor,
    fontSize: 15,
    fontWeight: FontWeight.w200,
  );

  static final listText = GoogleFonts.poppins(
    color: primaryColor,
    fontSize: 20,
  );

  static final buttonText = GoogleFonts.poppins(
    fontSize: 18,
    letterSpacing: 1.5,
    fontWeight: FontWeight.bold,
  );

  static final mainButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: mainColor,
    foregroundColor: primaryColor,
    elevation: 24,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  );
}