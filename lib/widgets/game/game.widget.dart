import 'package:flutter/material.dart';
import 'package:minesweeper/blocs/game.bloc.dart';
import 'package:minesweeper/themes/theme.dart';
import 'package:minesweeper/widgets/game/square.widget.dart';
import 'package:provider/provider.dart';

class Game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GameBloc bloc = Provider.of<GameBloc>(context);
    bloc.putMines();
    return Container(
      alignment: Alignment.center,
      height: 415,
      decoration: buildBoxDecorationIn(),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: bloc.x,
        ),
        itemBuilder: _buildSquareItems,
        itemCount: bloc.x * bloc.y,
      ),
    );
  }

  Widget _buildSquareItems(BuildContext context, int index) {
    GameBloc bloc = Provider.of<GameBloc>(context);
    int gridStateLength = bloc.gridState.length;
    int x, y = 0;
    x = (index / gridStateLength).floor();
    y = (index % gridStateLength);
    return GestureDetector(
      onTap: () {
        bloc.onTap(x, y);
      },
      child: GridTile(
        child: Square(x: x, y: y),
      ),
    );
  }
}
