import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minesweeper/blocs/game.bloc.dart';
import 'package:minesweeper/themes/theme.dart';
import 'package:provider/provider.dart';

class GameArena extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<GameBloc>(context);
    return Container(
      decoration: buildBoxDecorationIn(),
      child: Container(
        decoration: buildBoxDecorationIn(),
        child: Table(
          children: buildRows(bloc.rows, bloc.columns, context),
        ),
      ),
    );
  }

  List<TableRow> buildRows(int row, int col, BuildContext context) {
    var rows = List<TableRow>.filled(row, null);
    for (var i = 0; i < row; i++) {
      rows[i] = TableRow(
        children: buildItems(i, col),
      );
    }
    return rows;
  }

  List<Widget> buildItems(int rowIndex, int length) {
    List<Widget> widgets = List<Widget>.filled(length, null);
    for (var i = 0; i < length; i++) {
      widgets[i] = Area(
        rowPosition: rowIndex,
        colPosition: i,
      );
    }
    return widgets;
  }
}

class Area extends StatelessWidget {
  final int rowPosition;
  final int colPosition;

  const Area({
    @required this.rowPosition,
    @required this.colPosition,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<GameBloc>(context);

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
