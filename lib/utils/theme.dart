import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'palette.dart';

final ThemeData mainTheme = ThemeData(
  primaryColor: primaryColor,
  primaryTextTheme: TextTheme(
    button: TextStyle(color: Colors.white),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
  ),
  textTheme: GoogleFonts.signikaTextTheme(),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  ),
  useMaterial3: true,
);
