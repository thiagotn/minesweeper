import 'package:flutter/material.dart';
import 'package:minesweeper/blocs/game.bloc.dart';
import 'package:minesweeper/themes/theme.dart';
import 'package:minesweeper/widgets/game/square.widget.dart';
import 'package:provider/provider.dart';

class Game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GameBloc bloc = Provider.of<GameBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate available space for the grid
          final availableWidth = constraints.maxWidth - 16.0; // Account for padding
          final availableHeight = constraints.maxHeight - 16.0;
          
          // Calculate the maximum square size that fits within constraints
          final maxSquareSizeByWidth = availableWidth / bloc.columns;
          final maxSquareSizeByHeight = availableHeight / bloc.rows;
          final squareSize = (maxSquareSizeByWidth < maxSquareSizeByHeight 
              ? maxSquareSizeByWidth 
              : maxSquareSizeByHeight).clamp(18.0, 45.0); // Mobile-optimized range
          
          return Container(
            alignment: Alignment.center,
            decoration: buildBoxDecorationIn(),
            child: GridView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: bloc.rows,
                childAspectRatio: 1.0,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
              ),
              itemBuilder: (context, index) => _buildSquareItems(context, index, squareSize),
              itemCount: bloc.rows * bloc.columns,
            ),
          );
        },
      ),
    );
  }

  Widget _buildSquareItems(BuildContext context, int index, double squareSize) {
    GameBloc bloc = Provider.of<GameBloc>(context);
    int x, y = 0;
    x = (index / bloc.rows).floor();
    y = (index % bloc.columns);
    if (bloc.lose) {
      return GridTile(
        child: Square(x: x, y: y, size: squareSize),
      );
    }
    return GestureDetector(
      onLongPress: () => bloc.onLongPress(x, y),
      onTap: () => bloc.onTap(x, y),
      child: GridTile(
        child: Square(x: x, y: y, size: squareSize),
      ),
    );
  }
}
