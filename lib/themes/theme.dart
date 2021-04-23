import 'package:flutter/material.dart';

const brightness = Brightness.light;
const primaryColor = Colors.grey;
const accentColor = const Color(0xFFFFFFFF);
const primarySwatch = Colors.grey;
const fontFamily = 'TickingTimebombBB';

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

BoxDecoration buildBoxDecorationScoreBoard() {
  return BoxDecoration(
    color: Colors.black,
    border: Border(
      top: BorderSide(color: Colors.grey, width: 3.0),
      left: BorderSide(color: Colors.grey, width: 3.0),
      bottom: BorderSide(color: Colors.white, width: 3.0),
      right: BorderSide(color: Colors.white, width: 3.0),
    ),
  );
}

BoxDecoration buildBoxDecorationClicked() {
  return BoxDecoration(
    color: Color(0xffbcbcbc),
    border: Border(
      // top: BorderSide(color: Colors.black, width: 0.5),
      // left: BorderSide(color: Colors.black, width: 0.5),
      bottom: BorderSide(color: Colors.black, width: 0.5),
      right: BorderSide(color: Colors.black, width: 0.5),
    ),
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
