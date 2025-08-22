import 'package:flutter/material.dart';
import 'package:minesweeper/widgets/game/actions.widget.dart';
import 'package:minesweeper/widgets/game/app-bar.widget.dart';
import 'package:minesweeper/widgets/game/game.widget.dart';
import 'package:minesweeper/widgets/game/game.web.widget.dart';
import 'package:minesweeper/widgets/game/scoreboard.widget.dart';

class GamePageWeb extends StatelessWidget {
  const GamePageWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gameAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 800;

          if (isWide) {
            return Row(
              children: [
                Expanded(
                  flex: 3,
                  child: GameWeb(),
                ),
                Expanded(
                  flex: 1,
                  child: ListView(
                    children: [
                      Scoreboard(),
                      GameActions(),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return ListView(
              children: [
                Scoreboard(),
                InteractiveViewer(
                  child: Game(),
                ),
                GameActions(),
              ],
            );
          }
        },
      ),
    );
  }
}
