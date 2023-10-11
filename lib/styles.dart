import 'package:flutter/material.dart';

class CustomStyle {
  static const primaryColor = Colors.white;
  static final mainColor = Colors.redAccent[700];

  static const movieTitle = TextStyle(
    color: primaryColor,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  );

  static final normalText = TextStyle(
    color: Colors.grey[300],
    fontSize: 16,
  );

  static const description = TextStyle(
    color: primaryColor,
    fontSize: 16,
    fontWeight: FontWeight.w300,
  );

  static const listText = TextStyle(
    color: primaryColor,
    fontSize: 20,
  );

  static const buttonText = TextStyle(
    fontSize: 18,
    letterSpacing: 1,
    fontWeight: FontWeight.bold,
  );

  static final mainButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: mainColor,
    foregroundColor: primaryColor,
    elevation: 24,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  );
}