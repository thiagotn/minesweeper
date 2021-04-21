import 'package:flutter/material.dart';
import 'package:minesweeper/widgets/game/actions.widget.dart';
import 'package:minesweeper/widgets/game/app-bar.widget.dart';
import 'package:minesweeper/widgets/game/game.widget.dart';
import 'package:minesweeper/widgets/game/scoreboard.widget.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gameAppBar(),
      body: ListView(
        children: [
          Scoreboard(),
          Game(),
          GameActions(),
        ],
      ),
    );
  }
}
