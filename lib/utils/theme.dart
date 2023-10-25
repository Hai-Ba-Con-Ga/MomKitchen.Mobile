import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';
import 'palette.dart';

final ThemeData mainTheme = ThemeData(
  primaryTextTheme: const TextTheme(
    button: TextStyle(color: Colors.white),
  ),
  colorScheme: lightColorScheme,
  textTheme: GoogleFonts.signikaTextTheme(),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(fontSize: 16, color: Colors.white),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  ),
  useMaterial3: true,
);
