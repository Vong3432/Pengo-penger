import 'dart:ui';

import 'package:flutter/material.dart';

Map<int, Color> color = <int, Color>{
  50: const Color.fromRGBO(90, 168, 42, .1),
  100: const Color.fromRGBO(90, 168, 42, .2),
  200: const Color.fromRGBO(90, 168, 42, .3),
  300: const Color.fromRGBO(90, 168, 42, .4),
  400: const Color.fromRGBO(90, 168, 42, .5),
  500: const Color.fromRGBO(90, 168, 42, .6),
  600: const Color.fromRGBO(90, 168, 42, .7),
  700: const Color.fromRGBO(90, 168, 42, .8),
  800: const Color.fromRGBO(90, 168, 42, .9),
  900: const Color.fromRGBO(90, 168, 42, 1),
};

Map<int, Color> text = <int, Color>{
  50: const Color.fromRGBO(26, 33, 46, .1),
  100: const Color.fromRGBO(26, 33, 46, .2),
  200: const Color.fromRGBO(26, 33, 46, .3),
  300: const Color.fromRGBO(26, 33, 46, .4),
  400: const Color.fromRGBO(26, 33, 46, .5),
  500: const Color.fromRGBO(26, 33, 46, .6),
  600: const Color.fromRGBO(26, 33, 46, .7),
  700: const Color.fromRGBO(26, 33, 46, .8),
  800: const Color.fromRGBO(26, 33, 46, .9),
  900: const Color.fromRGBO(26, 33, 46, 1),
};

Map<int, Color> danger = <int, Color>{
  50: const Color.fromRGBO(250, 98, 125, .1),
  100: const Color.fromRGBO(250, 98, 125, .2),
  200: const Color.fromRGBO(250, 98, 125, .3),
  300: const Color.fromRGBO(250, 98, 125, .4),
  400: const Color.fromRGBO(250, 98, 125, .5),
  500: const Color.fromRGBO(250, 98, 125, .6),
  600: const Color.fromRGBO(250, 98, 125, .7),
  700: const Color.fromRGBO(250, 98, 125, .8),
  800: const Color.fromRGBO(250, 98, 125, .9),
  900: const Color.fromRGBO(250, 98, 125, 1),
};

Map<int, Color> success = <int, Color>{
  50: const Color.fromRGBO(20, 152, 73, .1),
  100: const Color.fromRGBO(20, 152, 73, .2),
  200: const Color.fromRGBO(20, 152, 73, .3),
  300: const Color.fromRGBO(20, 152, 73, .4),
  400: const Color.fromRGBO(20, 152, 73, .5),
  500: const Color.fromRGBO(20, 152, 73, .6),
  600: const Color.fromRGBO(20, 152, 73, .7),
  700: const Color.fromRGBO(20, 152, 73, .8),
  800: const Color.fromRGBO(20, 152, 73, .9),
  900: const Color.fromRGBO(20, 152, 73, 1),
};

// Colors
MaterialColor primaryColor = MaterialColor(0xFF5AA82A, color);
MaterialColor dangerColor = MaterialColor(0xFFFA627D, color);
MaterialColor successColor = MaterialColor(0xFF149849, color);
MaterialColor textColor = MaterialColor(0xFF151615, text);
Color primaryLightColor = const Color(0xFFEDFFE2);
Color grayTextColor = const Color(0xFF4B5656);
Color secondaryTextColor = const Color(0xFF727373);
Color blueColor = const Color(0xFF5D78D9);
Color greyBgColor = const Color(0xFFF0F0F3);
Color whiteColor = Colors.white;

// Gradient
LinearGradient primaryLinear = const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[
    Color(0xFF4E7EFA),
    Color(0xFF49C8C0),
  ],
);
