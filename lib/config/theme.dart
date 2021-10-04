import 'package:flutter/material.dart';
import 'package:penger/config/color.dart';

ThemeData themeData = ThemeData(
  primarySwatch: primaryColor,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.white,
  dividerTheme: DividerThemeData(color: greyBgColor, thickness: 2.5),
  dividerColor: greyBgColor,
  iconTheme: IconThemeData(color: textColor),
  appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: textColor)),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
    filled: true,
    fillColor: greyBgColor,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 28,
      letterSpacing: -1,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    headline4: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    headline5: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
    headline6: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    bodyText1: TextStyle(fontFamily: 'Work Sans', height: 1.6),
    bodyText2: TextStyle(fontFamily: 'Work Sans', height: 1.6),
    subtitle1: TextStyle(fontFamily: 'Work Sans', fontWeight: FontWeight.w500),
    subtitle2: TextStyle(fontFamily: 'Work Sans', fontWeight: FontWeight.w500),
    caption: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
  ).apply(
    bodyColor: textColor,
    displayColor: textColor,
  ),
  platform: TargetPlatform.iOS,
);
