import 'package:flutter/material.dart';

//Light Mode
const lightPrimary = Color(0xFFF3F4F6);
const lightPrimaryVariant = Color(0xFFF9FAFB);
const lightSecondary = Color(0xFFE5E7EB);
const lightAccent = Color(0xFFFB923C);
const lightAccentVariant = Color(0xFFF97316);

//Dark Mode
const darkPrimary = Color(0xFF1F2937);
const darkPrimaryVariant = Color(0xFF111827);
const darkSecondary = Color(0xFF374151);
const darkAccent = Color(0xFF7C3AED);
const darkAccentVariant = Color(0xFF6D28D9);

//Universal
const neutral = Color(0xFF6B7280);
const danger = Color(0xFFEF4444);
const approve = Color(0xFF63CF48);

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  primaryColor: lightPrimary,
  primaryColorLight: lightPrimaryVariant,
  primaryColorDark: lightSecondary,
  focusColor: lightAccent,
  highlightColor: lightAccentVariant,

  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: darkAccent,
      )
  ),

  textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontFamily: 'Poppins',
      ),

      bodySmall: TextStyle(
        fontFamily: 'Poppins',
      ),

      bodyMedium: TextStyle(
        fontFamily: 'Poppins',
      ),

      headlineLarge: TextStyle(
          fontFamily: 'League Spartan'
      ),

      headlineMedium: TextStyle(
          fontFamily: 'League Spartan'
      ),

      headlineSmall: TextStyle(
          fontFamily: 'League Spartan'
      ),
    )
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  primaryColor: darkPrimary,
  primaryColorLight: darkPrimaryVariant,
  primaryColorDark: darkSecondary,
  focusColor: darkAccent,
  highlightColor: darkAccentVariant,

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: darkAccent,
    )
  ),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16
    ),

    bodySmall: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12
    ),

    bodyMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14
    ),

    headlineLarge: TextStyle(
      fontFamily: 'League Spartan'
    ),

    headlineMedium: TextStyle(
        fontFamily: 'League Spartan'
    ),

    headlineSmall: TextStyle(
        fontFamily: 'League Spartan'
    ),

    labelMedium: TextStyle(
      fontFamily: 'PoppinsSemibold',
      fontSize: 12
    ),
  )
);