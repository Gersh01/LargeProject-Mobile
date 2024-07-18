import 'package:flutter/material.dart';

//Light Mode
const lightPrimary = Color(0xFFF3F4F6);
const lightPrimaryVariant = Color(0xFFF9FAFB);
const lightSecondary = Color(0xFFE5E7EB);
const lightAccent = Color(0xFFFB923C);
const lightAccentVariant = Color(0xFFF97316);
const lightSearchBar = Color(0xffe5e7eb);

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
    dialogBackgroundColor: lightSearchBar,
    focusColor: lightAccent,
    highlightColor: lightAccentVariant,
    hintColor: Colors.black,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      foregroundColor: darkAccent,
    )),
    textTheme: const TextTheme(
      bodyLarge:
          TextStyle(fontFamily: 'Poppins', fontSize: 18, color: Colors.black),
      bodySmall:
          TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.black),
      bodyMedium:
          TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.black),
      headlineLarge:
          TextStyle(fontFamily: 'League Spartan', color: Colors.black),
      headlineMedium:
          TextStyle(fontFamily: 'League Spartan', color: Colors.black),
      headlineSmall:
          TextStyle(fontFamily: 'League Spartan', color: Colors.black),
    ));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    dialogBackgroundColor: darkSecondary,
    primaryColor: darkPrimary,
    primaryColorLight: darkSecondary,
    primaryColorDark: darkPrimaryVariant,
    focusColor: darkAccent,
    highlightColor: darkAccentVariant,
    hintColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      foregroundColor: darkAccent,
    )),
    textTheme: const TextTheme(
      bodyLarge:
          TextStyle(fontFamily: 'Poppins', fontSize: 18, color: Colors.white),
      bodySmall:
          TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.white),
      bodyMedium:
          TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.white),
      headlineLarge: TextStyle(
          fontFamily: 'League Spartan', fontSize: 14, color: Colors.white),
      headlineMedium:
          TextStyle(fontFamily: 'League Spartan', color: Colors.white),
      headlineSmall: TextStyle(
          fontFamily: 'League Spartan', fontSize: 12, color: Colors.white),
      labelMedium: TextStyle(
          fontFamily: 'PoppinsSemibold', fontSize: 12, color: Colors.white),
    ),
    iconTheme: const IconThemeData(color: Colors.white, size: 14));
