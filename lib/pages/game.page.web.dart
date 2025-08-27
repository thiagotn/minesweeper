import 'package:flutter/material.dart';
import 'package:minesweeper/blocs/game.bloc.dart';
import 'package:minesweeper/utils/game_web_dimensions.dart';
import 'package:minesweeper/widgets/game/actions.widget.dart';
import 'package:minesweeper/widgets/game/app-bar.widget.dart';
import 'package:minesweeper/widgets/game/game.widget.dart';
import 'package:minesweeper/widgets/game/game.web.widget.dart';
import 'package:minesweeper/widgets/game/scoreboard.widget.dart';
import 'package:minesweeper/widgets/version_footer.widget.dart';
import 'package:provider/provider.dart';

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
            final bloc = Provider.of<GameBloc>(context);
            final gameWebWidth = GameWebDimensions.calculateGameWebWidth(constraints, bloc);
            
            return Column(
              children: [
                Scoreboard(width: gameWebWidth),
                Expanded(
                  child: Center(
                    child: GameWeb(),
                  ),
                ),
                GameActions(width: gameWebWidth),
                VersionFooter(),
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
                VersionFooter(),
              ],
            );
          }
        },
      ),
    );
  }
}
