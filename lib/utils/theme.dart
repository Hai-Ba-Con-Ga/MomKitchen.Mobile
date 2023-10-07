import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData mainTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color.fromRGBO(255, 118, 34, 1),
  ),
  textTheme: GoogleFonts.signikaTextTheme(),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(Color.fromRGBO(255, 118, 34, 1)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  ),
  useMaterial3: true,
);
