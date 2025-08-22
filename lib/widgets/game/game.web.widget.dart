import 'package:flutter/material.dart';
import 'package:minesweeper/blocs/game.bloc.dart';
import 'package:minesweeper/themes/theme.dart';
import 'package:minesweeper/widgets/game/square.widget.dart';
import 'package:provider/provider.dart';

class GameWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GameBloc bloc = Provider.of<GameBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      child: Container(
        alignment: Alignment.center,
        decoration: buildBoxDecorationIn(),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: bloc.columns,
          ),
          itemBuilder: _buildSquareItems,
          itemCount: bloc.rows * bloc.columns,
        ),
      ),
    );
  }

  Widget _buildSquareItems(BuildContext context, int index) {
    GameBloc bloc = Provider.of<GameBloc>(context);
    int x, y = 0;
    x = (index / bloc.columns).floor();
    y = (index % bloc.columns);
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
