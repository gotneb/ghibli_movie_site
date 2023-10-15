import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomStyle {
  static const primaryColor = Colors.white;
  static final mainColor = Colors.redAccent[700];
  static const blackColor = Color(0xFF0D0D0D);
  static const greyColor = Color(0xFF202020);
  static const shadows = [
    Shadow(
      blurRadius: 3,
      color: Colors.black,
    )
  ];

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

  static final normalText2 = GoogleFonts.poppins(
    color: Colors.grey[300],
    fontSize: 15,
    shadows: shadows,
  );

  static final description = GoogleFonts.poppins(
    color: primaryColor,
    fontSize: 16,
    fontWeight: FontWeight.w300,
  );

  static final ratingText = GoogleFonts.poppins(
    color: primaryColor,
    fontSize: 36,
    fontWeight: FontWeight.bold,
    shadows: shadows,
  );

  static final galleryText = GoogleFonts.poppins(
    color: primaryColor,
    fontSize: 20,
    letterSpacing: 1.5,
    shadows: shadows,
  );

  static final description2 = GoogleFonts.nunito(
    color: primaryColor,
    fontSize: 18,
    //fontWeight: FontWeight.w300,
    shadows: shadows,
  );

  static final movieTitle2 = GoogleFonts.nunito(
    color: primaryColor,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
    shadows: const [Shadow(blurRadius: 2, color: Colors.black, offset: Offset(1, 1))],
  );

  static final movieTitle3 = GoogleFonts.nunito(
    color: primaryColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
    shadows: shadows,
  );

  static final hintText = GoogleFonts.poppins(
    color: Colors.grey,
    fontSize: 16,
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
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  );

  static final mainButtonStyle2 = ElevatedButton.styleFrom(
    backgroundColor: blackColor,
    surfaceTintColor: blackColor,
    foregroundColor: primaryColor,
    side: const BorderSide(color: primaryColor, width: 2),
    elevation: 24,
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  );
}
