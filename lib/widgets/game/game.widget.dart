import 'package:flutter/material.dart';
import 'package:minesweeper/blocs/game.bloc.dart';
import 'package:minesweeper/blocs/game.config.dart';
import 'package:minesweeper/themes/theme.dart';
import 'package:minesweeper/widgets/game/square.widget.dart';
import 'package:provider/provider.dart';

class Game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      child: Container(
        alignment: Alignment.center,
        decoration: buildBoxDecorationIn(),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Level.rows,
          ),
          itemBuilder: _buildSquareItems,
          itemCount: Level.rows * Level.columns,
        ),
      ),
    );
  }

  Widget _buildSquareItems(BuildContext context, int index) {
    GameBloc bloc = Provider.of<GameBloc>(context);
    int x, y = 0;
    x = (index / Level.rows).floor();
    y = (index % Level.columns);
    if (bloc.lose) {
      return GridTile(
        child: Square(x: x, y: y),
      );
    }
    return GestureDetector(
      onLongPress: () => bloc.onLongPress(x, y),
      onTap: () => bloc.onTap(x, y),
      child: GridTile(
        child: Square(x: x, y: y),
      ),
    );
  }
}
