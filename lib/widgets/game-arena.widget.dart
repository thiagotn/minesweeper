import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minesweeper/blocs/game.bloc.dart';
import 'package:minesweeper/themes/theme.dart';
import 'package:provider/provider.dart';

class GameArena extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buildBoxDecorationIn(),
      child: Container(
        decoration: buildBoxDecorationIn(),
        child: buildTable(context),
      ),
    );
  }

  Table buildTable(BuildContext context) {
    return Table(
      children: buildRows(16, 16, context),
    );
  }

  List<TableRow> buildRows(int row, int col, BuildContext context) {
    var items = List<TableRow>.filled(row, null);
    for (var i = 0; i < row; i++) {
      items[i] = TableRow(
        children: buildItems(i, col, context),
      );
    }
    return items;
  }

  List<Widget> buildItems(int rowIndex, int length, BuildContext context) {
    final bloc = Provider.of<GameBloc>(context);
    List<Widget> widgets = List<Widget>.filled(length, null);
    for (var i = 0; i < length; i++) {
      widgets[i] = GestureDetector(
        child: Container(
          height: 25,
          width: 25,
          decoration: buildBoxDecorationOut(),
          child: (bloc.lose)
              ? SvgPicture.asset("assets/images/bomb.svg")
              : Container(),
        ),
        onTap: () {
          print("item [$rowIndex][$i] clicked!");
          bloc.onTap(rowIndex, i);
        },
      );
    }
    return widgets;
  }
}
