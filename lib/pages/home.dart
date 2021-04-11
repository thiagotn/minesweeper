import 'package:flutter/material.dart';
import 'package:minesweeper/widgets/game-actions.widget.dart';
import 'package:minesweeper/widgets/game-app-bar.widget.dart';
import 'package:minesweeper/widgets/game-arena.widget.dart';
import 'package:minesweeper/widgets/scoreboard.widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gameAppBar(),
      body: Container(
        color: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Scoreboard(),
                GameArena(),
                SizedBox(
                  height: 10,
                ),
                GameActions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
