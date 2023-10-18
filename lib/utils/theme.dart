import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'palette.dart';

final ThemeData mainTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: Colors.white,
    secondary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFFFFFFFF),
    error: Color(0xFFF32424),
    onError: Color(0xFFFFFFFF),
    background: Color(0xFFFFFFFF),
    onBackground: Color(0xFFFFFFFF),
    surface: Colors.white,
    onSurface: const Color.fromARGB(255, 131, 131, 131),
  ),
  primaryColor: primaryColor,
  primaryTextTheme: const TextTheme(
    button: TextStyle(color: Colors.white),
  ),
  textTheme: GoogleFonts.signikaTextTheme(),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(fontSize: 16, color: Colors.white),
      ),
      // backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  ),
  useMaterial3: true,
);
