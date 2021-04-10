import 'package:flutter/material.dart';

const brightness = Brightness.light;
const primaryColor = Colors.grey;
const accentColor = const Color(0xFFFFFFFF);
const primarySwatch = Colors.grey;
const fontFamily = 'BungeeShade';

ThemeData appTheme() {
  return ThemeData(
    brightness: brightness,
    textTheme: new TextTheme(
      bodyText1: new TextStyle(
        fontFamily: fontFamily,
      ),
      bodyText2: TextStyle(
        fontFamily: fontFamily,
      ),
      button: TextStyle(
        fontFamily: fontFamily,
      ),
      caption: TextStyle(
        fontFamily: fontFamily,
      ),
      headline6: TextStyle(
        fontFamily: fontFamily,
      ),
      headline5: TextStyle(
        fontFamily: fontFamily,
      ),
      headline4: TextStyle(
        fontFamily: fontFamily,
      ),
      headline3: TextStyle(
        fontFamily: fontFamily,
      ),
      headline2: TextStyle(
        fontFamily: fontFamily,
      ),
      headline1: TextStyle(
        fontFamily: fontFamily,
      ),
      overline: TextStyle(
        fontFamily: fontFamily,
      ),
      subtitle2: TextStyle(
        fontFamily: fontFamily,
      ),
      subtitle1: TextStyle(
        fontFamily: fontFamily,
      ),
    ),
    primaryColor: primaryColor,
    accentColor: accentColor,
    primarySwatch: primarySwatch,
  );
}
