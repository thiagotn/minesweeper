import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minesweeper/blocs/game.bloc.dart';
import 'package:minesweeper/themes/theme.dart';
import 'package:provider/provider.dart';

class Square extends StatelessWidget {
  final int x;
  final int y;
  final double? size;

  const Square({
        required this.x,
    required this.y,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    GameBloc bloc = Provider.of<GameBloc>(context);
    var value = bloc.gridState[x][y];
    final squareSize = size ?? 25.0; // Default to 25 if no size provided
    final fontSize = (bloc.currentLevel == Level.HARD2) ? squareSize * 0.44 : squareSize * 0.56;
    
    switch (value) {
      case empty:
        return Container(
          width: squareSize,
          height: squareSize,
          decoration: buildBoxDecorationOut(),
        );
        break;
      case opened:
        return Container(
          width: squareSize,
          height: squareSize,
          decoration: buildBoxDecorationClicked(),
        );
        break;
      case hasFlag:
        return Container(
          width: squareSize,
          height: squareSize,
          decoration: buildBoxDecorationClicked(),
          child: SvgPicture.asset("assets/images/flag.svg"),
        );
        break;
      case hasMine:
        return Container(
          width: squareSize,
          height: squareSize,
          decoration: buildBoxDecorationIn(),
          child: SvgPicture.asset("assets/images/mine.svg"),
        );
        break;
      default:
        return Container(
          width: squareSize,
          height: squareSize,
          decoration: buildBoxDecorationClicked(),
          child: Center(
            child: Text(
              "$value",
              style: TextStyle(
                fontSize: fontSize,
                color: getColor(value),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
    }
  }

  getColor(value) {
    switch (value) {
      case 1:
        return Color(0xff000051);
        break;
      case 2:
        return Colors.green;
        break;
      case 3:
        return Colors.red;
        break;
      case 4:
        return Colors.purple;
        break;
      default:
    }
  }
}
