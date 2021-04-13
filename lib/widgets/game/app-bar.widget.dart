import 'package:flutter/material.dart';

AppBar gameAppBar() {
  return AppBar(
    title: Text(
      "Campo Minado",
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        fontFamily: 'BungeeShade',
      ),
    ),
    centerTitle: true,
  );
}
