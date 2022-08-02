import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  // we make the primary color for the whole application is deepOrange
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    // it's responsible for the bar above The AppBar which has battery/wifi/etc
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.red,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.black),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
  ),
  textTheme: const TextTheme(
    bodyText2: TextStyle(
      color: Colors.grey,
    ),
  ),
  fontFamily: 'Jannah',
);


ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black45,
  // we make the primary color for the whole application is deepOrange
  primarySwatch: defaultColor,
  appBarTheme: const AppBarTheme(
    // it's responsible for the bar above The AppBar which has battery/wifi/etc
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.red,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.black45,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
  ),
  textTheme: const TextTheme(
    bodyText2: TextStyle(
      color: Colors.white70,
    ),
    bodyText1: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: Colors.white
    ),
  ),
  brightness: Brightness.dark,
  fontFamily: 'Jannah',
);