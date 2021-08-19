import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: defaultColor,
  primaryTextTheme: TextTheme(headline6: TextStyle(color: Color(0xFF2B2D42))),
  appBarTheme: AppBarTheme(
    elevation: 0,
    color: Colors.white,
    brightness: Brightness.dark,
    iconTheme: IconThemeData(
      color: Color(0xFF2B2D42),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      elevation: 10.0,
      backgroundColor: Colors.white),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontFamily: 'Jannah',
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.red,
  scaffoldBackgroundColor: Color(0xFF2B2D42),
  appBarTheme: AppBarTheme(
    color: Color(0xFF2B2D42),
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.red,
    unselectedItemColor: Colors.grey,
    elevation: 10.0,
    backgroundColor: Color(0xFF2B2D42),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
);
