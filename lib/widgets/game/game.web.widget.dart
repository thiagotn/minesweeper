import 'package:flutter/material.dart';
import 'package:minesweeper/blocs/game.bloc.dart';
import 'package:minesweeper/themes/theme.dart';
import 'package:minesweeper/widgets/game/square.widget.dart';
import 'package:provider/provider.dart';

class GameWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GameBloc bloc = Provider.of<GameBloc>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate available space for the grid (accounting for padding and margins)
        final availableWidth = constraints.maxWidth * 0.9; // Use 90% of available width
        final availableHeight = constraints.maxHeight * 0.9; // Use 90% of available height
        
        // Calculate the maximum square size that fits within constraints
        final maxSquareSizeByWidth = availableWidth / bloc.columns;
        final maxSquareSizeByHeight = availableHeight / bloc.rows;
        final squareSize = (maxSquareSizeByWidth < maxSquareSizeByHeight 
            ? maxSquareSizeByWidth 
            : maxSquareSizeByHeight).clamp(12.0, 35.0); // Optimized range for web
        
        // Calculate total grid size
        final gridWidth = squareSize * bloc.columns;
        final gridHeight = squareSize * bloc.rows;
        
        return Center(
          child: Container(
            width: gridWidth + 16.0, // Add padding
            height: gridHeight + 16.0, // Add padding
            padding: const EdgeInsets.all(8.0),
            decoration: buildBoxDecorationIn(),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Prevent scrolling since we sized to fit
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: bloc.columns,
                childAspectRatio: 1.0,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
              ),
              itemBuilder: (context, index) => _buildSquareItems(context, index, squareSize),
              itemCount: bloc.rows * bloc.columns,
            ),
          ),
        );
      },
    );
  }

  Widget _buildSquareItems(BuildContext context, int index, double squareSize) {
    GameBloc bloc = Provider.of<GameBloc>(context);
    int x, y = 0;
    x = (index / bloc.columns).floor();
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
