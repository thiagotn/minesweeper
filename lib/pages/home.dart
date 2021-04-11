import 'package:flutter/material.dart';
import 'package:minesweeper/widgets/game-actions.widget.dart';
import 'package:minesweeper/widgets/game-arena.widget.dart';
import 'package:minesweeper/widgets/scoreboard.widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Campo Minado",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            fontFamily: 'BungeeShade',
          ),
        ),
        centerTitle: true,
      ),
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
