import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: Colors.teal.shade900,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  dividerTheme: DividerThemeData(
    thickness: 0.5,
    space: 0,
    color: Colors.teal.shade500,
  ),
  listTileTheme: ListTileThemeData(
    textColor: Colors.teal.shade900,
    tileColor: Colors.teal.shade50,
    iconColor: Colors.teal.shade900,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  navigationDrawerTheme: NavigationDrawerThemeData(
    backgroundColor: Colors.teal.shade50,
    elevation: 1,
    shadowColor: Colors.teal.shade400,
  ),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    shadowColor: Colors.teal.shade900,
    elevation: 1,
    color: Colors.white,
    titleTextStyle: TextStyle(
        color: Colors.teal.shade900, fontSize: 20, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: Colors.teal.shade900),
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.teal.shade900,
    secondary: Colors.teal.shade200,
    surface: Colors.teal.shade50,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.teal.shade900,
  ),
);

final ThemeData darkTheme = ThemeData(
  primaryColor: Colors.teal.shade900,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  dividerTheme: DividerThemeData(
    thickness: 0.5,
    space: 0,
    color: Colors.teal.shade50,
  ),
  listTileTheme: ListTileThemeData(
    textColor: Colors.white,
    tileColor: Colors.teal.shade800,
    iconColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  navigationDrawerTheme: NavigationDrawerThemeData(
    backgroundColor: Colors.teal.shade800,
    elevation: 1,
    shadowColor: Colors.teal.shade900,
  ),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    shadowColor: Colors.teal.shade900,
    elevation: 1,
    color: Colors.black,
    titleTextStyle: const TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.teal.shade900,
    secondary: Colors.teal.shade600,
    surface: Colors.teal.shade800,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
  ),
);
