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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Scoreboard(),
          SizedBox(
            height: 10,
          ),
          Game(),
          SizedBox(
            height: 10,
          ),
          GameActions(),
        ],
      ),
    );
  }
}
