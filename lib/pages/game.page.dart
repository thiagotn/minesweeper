import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minesweeper/blocs/game.bloc.dart';
import 'package:minesweeper/themes/theme.dart';
import 'package:minesweeper/widgets/game-actions.widget.dart';
import 'package:minesweeper/widgets/game-app-bar.widget.dart';
import 'package:minesweeper/widgets/scoreboard.widget.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gameAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Scoreboard(),
          SizedBox(
            height: 10,
          ),
          _buildGameBody(context),
          SizedBox(
            height: 10,
          ),
          GameActions(),
        ],
      ),
    );
  }

  Widget _buildGameBody(BuildContext context) {
    GameBloc bloc = Provider.of<GameBloc>(context);
    bloc.putMines();
    return Container(
      alignment: Alignment.center,
      height: 395,
      decoration: buildBoxDecorationIn(),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: bloc.x,
        ),
        itemBuilder: _buildGridItems,
        itemCount: bloc.x * bloc.y,
      ),
    );
  }

  Widget _buildGridItems(BuildContext context, int index) {
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
        child: GridItem(x: x, y: y),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final int x;
  final int y;

  const GridItem({
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
