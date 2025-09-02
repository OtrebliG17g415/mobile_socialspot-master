import 'package:flutter/material.dart';
import 'package:social_spot/helpers/colors.dart';

// APP LIGHT THEME
final appLightTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFFF9F9F9),
  primaryColor: appPrimaryColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: appPrimaryColor,
    brightness: Brightness.light,
  ),
  useMaterial3: true,
  fontFamily: 'Ubuntu',
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 11,
    ),
    hoverColor: Colors.grey.shade300,
    filled: true,
    fillColor: Colors.white,
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade400,
        width: 0.7,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade400,
        width: 0.7,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade400,
        width: 0.7,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  ),

  // Définir la couleur par défaut pour le texte
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: Color(0xFF2B3445),
      fontSize: 14,
      fontFamily: 'Ubuntu',
    ), // Couleur du texte par défaut
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.grey[600],
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Colors.white,
    elevation: 0,
  ),
);
