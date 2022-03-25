import 'package:flutter/material.dart';

const brightness = Brightness.light;
const primaryColor = Colors.grey;
const accentColor = const Color(0xFFFFFFFF);
const primarySwatch = Colors.grey;

ThemeData appThemeSimple() {
  return ThemeData(
    brightness: brightness,
    primaryColor: primaryColor,
    primarySwatch: primarySwatch,
  );
}

BoxDecoration buildBoxDecorationScoreBoard() {
  return BoxDecoration(
    color: Colors.red.shade900,
    border: Border(
      top: BorderSide(color: Colors.red.shade50, width: 3.0),
      left: BorderSide(color: Colors.red.shade50, width: 3.0),
      bottom: BorderSide(color: Colors.red.shade300, width: 3.0),
      right: BorderSide(color: Colors.red.shade300, width: 3.0),
    ),
  );
}

BoxDecoration buildBoxDecorationClicked() {
  return BoxDecoration(
    color: Color(0xffbcbcbc),
  );
}

BoxDecoration buildBoxDecorationIn() {
  return BoxDecoration(
    color: Color(0xffbcbcbc),
    border: Border(
      top: BorderSide(color: Colors.grey, width: 3.0),
      left: BorderSide(color: Colors.grey, width: 3.0),
      bottom: BorderSide(color: Colors.white, width: 3.0),
      right: BorderSide(color: Colors.white, width: 3.0),
    ),
  );
}

BoxDecoration buildBoxDecorationOut() {
  return BoxDecoration(
    color: Color(0xeeeeee),
    border: Border(
      top: BorderSide(color: Colors.white, width: 3.0),
      left: BorderSide(color: Colors.white, width: 3.0),
      bottom: BorderSide(color: Colors.grey, width: 3.0),
      right: BorderSide(color: Colors.grey, width: 3.0),
    ),
  );
}
