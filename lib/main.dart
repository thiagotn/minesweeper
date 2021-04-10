import 'package:flutter/material.dart';
import 'package:minesweeper/themes/theme.dart';

import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campo Minado',
      theme: appTheme(),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
