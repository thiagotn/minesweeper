import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minesweeper/themes/theme.dart';
import 'package:minesweeper/widgets/game-actions.widget.dart';
import 'package:minesweeper/widgets/game-app-bar.widget.dart';
import 'package:minesweeper/widgets/scoreboard.widget.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static final int x = 16; // rows
  static final int y = 16; // columns
  static final int mines = 26; // mines

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
          _buildGameBody(16),
          SizedBox(
            height: 10,
          ),
          GameActions(),
        ],
      ),
    );
  }

  List<List<String>> gridState =
      List.generate(x, (i) => List.generate(y, (j) => ""));

  List<List<String>> gridStateWithMines =
      List.generate(x, (i) => List.generate(y, (j) => ""));

  List<List<String>> clean(List<List<String>> gridState) {
    for (var i = 0; i < x; i++) {
      for (var j = 0; j < y; j++) {
        gridState[i][j] = '';
      }
    }
    return gridState;
  }

  putMines() {
    clean(gridStateWithMines);
    for (var i = 0; i < mines; i++) {
      int randomRowIndex;
      int randomColumnIndex;

      do {
        randomRowIndex = _random(0, x - 1);
        randomColumnIndex = _random(0, y - 1);
      } while (gridState[randomRowIndex][randomColumnIndex] == 'X');

      gridStateWithMines[randomRowIndex][randomColumnIndex] = 'X';
    }
  }

  int _random(int min, int max) {
    Random rnd;
    int min = 0;
    rnd = new Random();
    var result = min + rnd.nextInt(max - min);
    return result;
  }

  Widget _buildGameBody(int length) {
    putMines();
    int gridStateLength = length;
    return Container(
      alignment: Alignment.center,
      height: 395,
      decoration: buildBoxDecorationIn(),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridStateLength,
        ),
        itemBuilder: _buildGridItems,
        itemCount: gridStateLength * gridStateLength,
      ),
    );
  }

  Widget _buildGridItems(BuildContext context, int index) {
    int gridStateLength = gridState.length;
    int x, y = 0;
    x = (index / gridStateLength).floor();
    y = (index % gridStateLength);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (gridStateWithMines[x][y] == '') {
            gridState[x][y] = '0';
          } else if (gridStateWithMines[x][y] == 'X') {
            gridState[x][y] = 'X';
            gridStateWithMines[x][y] = 'X';
            mergeGrids();
          }
        });
        print("tapped: $x $y");
      },
      child: GridTile(
        child: _buildGridItem(x, y),
      ),
    );
  }

  Widget _buildGridItem(int x, int y) {
    switch (gridState[x][y]) {
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

  void mergeGrids() {
    for (var i = 0; i < x; i++) {
      for (var j = 0; j < y; j++) {
        if (gridStateWithMines[i][j] == 'X') {
          gridState[i][j] = gridStateWithMines[i][j];
        }
      }
    }
  }
}
