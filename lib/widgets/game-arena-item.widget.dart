import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minesweeper/blocs/game.bloc.dart';
import 'package:minesweeper/themes/theme.dart';
import 'package:provider/provider.dart';

class AreaItem extends StatelessWidget {
  final int rowPosition;
  final int colPosition;
  final int content;

  const AreaItem({
    @required this.rowPosition,
    @required this.colPosition,
    @required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<GameBloc>(context);
    print("content $content for [$rowPosition][$colPosition]");
    return GestureDetector(
      child: Container(
        height: 25,
        width: 25,
        decoration: buildBoxDecorationOut(),
        //  (bloc.containsMine(rowPosition, colPosition))
        //     ? buildBoxDecorationClicked()
        //     : buildBoxDecorationOut(),
        child: (bloc.containsMine(rowPosition, colPosition) && bloc.lose)
            ? SvgPicture.asset("assets/images/bomb.svg")
            : Container(),
      ),
      onTap: () {
        print("item [$rowPosition][$colPosition] clicked!");
        bloc.onTap(rowPosition, colPosition);
        // if (bloc.containsMine(rowIndex, i)) {}
      },
    );
  }
}
