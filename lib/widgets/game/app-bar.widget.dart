import 'package:flutter/material.dart';

AppBar gameAppBar() {
  return AppBar(
    title: Text(
      "Campo Minado",
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        fontFamily: 'BungeeShade',
      ),
    ),
    actions: [],
    centerTitle: true,
  );
}
