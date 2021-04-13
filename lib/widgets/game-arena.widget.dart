import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minesweeper/blocs/game.bloc.dart';
import 'package:minesweeper/themes/theme.dart';
import 'package:provider/provider.dart';

class GameArena extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<GameBloc>(context);
    bloc.putMines();
    return Container(
      decoration: buildBoxDecorationIn(),
      child: Container(
        decoration: buildBoxDecorationIn(),
        child: Consumer<GameBloc>(
          builder: (context, bloc, child) {
            if (bloc.gridState == null) {
              return CircularProgressIndicator();
            }
            return _buildGameBody(bloc.rows, context);
          },
        ),
      ),
    );
  }

  Widget _buildGameBody(int length, BuildContext context) {
    final bloc = Provider.of<GameBloc>(context);
    bloc.putMines();
    int gridStateLength = length;
    return Column(children: <Widget>[
      AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2.0)),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridStateLength,
            ),
            itemBuilder: _buildGridItems,
            itemCount: gridStateLength * gridStateLength,
          ),
        ),
      ),
    ]);
  }

  Widget _buildGridItems(BuildContext context, int index) {
    final bloc = Provider.of<GameBloc>(context);
    int gridStateLength = bloc.columns;
    int x, y = 0;
    x = (index / gridStateLength).floor();
    y = (index % gridStateLength);
    return GestureDetector(
      onTap: () {
        bloc.onTap(x, y);
      },
      child: GridTile(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.5)),
          child: Center(
            child: buildGridItem(context, x, y),
          ),
        ),
      ),
    );
  }

  Widget buildGridItem(BuildContext context, int x, int y) {
    final bloc = Provider.of<GameBloc>(context);
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
          child: SvgPicture.asset("assets/images/bomb.svg"),
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
