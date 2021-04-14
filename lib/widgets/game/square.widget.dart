import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minesweeper/blocs/game.bloc.dart';
import 'package:minesweeper/themes/theme.dart';
import 'package:provider/provider.dart';

class Square extends StatelessWidget {
  final int x;
  final int y;

  const Square({
    @required this.x,
    @required this.y,
  });

  @override
  Widget build(BuildContext context) {
    GameBloc bloc = Provider.of<GameBloc>(context);
    switch (bloc.gridState[x][y]) {
      case '':
        return Container(
          width: 25,
          height: 25,
          decoration: buildBoxDecorationOut(),
        );
        break;
      case '0':
        return Container(
          width: 25,
          height: 25,
          decoration: buildBoxDecorationClicked(),
        );
        break;
      case 'X':
        return Container(
          width: 25,
          height: 25,
          decoration: buildBoxDecorationIn(),
          child: SvgPicture.asset("assets/images/mine.svg"),
        );
        break;
      default:
        return Container(
          width: 25,
          height: 25,
          decoration: buildBoxDecorationOut(),
        );
    }
  }
}
