import 'package:flutter/material.dart';
import 'package:minesweeper/blocs/game.bloc.dart';
import 'package:minesweeper/pages/game.page.dart';
import 'package:minesweeper/themes/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GameBloc>.value(
          value: GameBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Campo Minado',
        theme: appTheme(),
        home: GamePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
