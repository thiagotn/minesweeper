import 'package:flutter/material.dart';
import 'package:minesweeper/blocs/game.bloc.dart';
import 'package:minesweeper/themes/theme.dart';
import 'package:provider/provider.dart';

class GameActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<GameBloc>(context);
    return GestureDetector(
      child: Container(
        decoration: buildBoxDecorationOut(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Recomeçar",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      onTap: () {
        bloc.restart();
      },
    );
  }
}
