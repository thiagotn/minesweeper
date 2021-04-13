import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minesweeper/themes/theme.dart';

class GameBloc extends ChangeNotifier {
  int played = 0;
  int score = 0;
  bool lose = false;
  bool started = false;

  int rows = 16;
  int columns = 16;
  int mines = 26;
  var game; // store mines...

  List<List<String>> gridState;
  List<List<String>> gridStateWithMines;

  start() {
    played = 0;
    score = 0;
    lose = false;
    started = true;
    putMines();
    gridState = buildInitialGrid();
    gridStateWithMines = buildInitialGrid();
    notifyListeners();
  }

  restart() {
    played = 0;
    score = 0;
    lose = false;
    started = true;
    putMines();
    gridState = buildInitialGrid();
    gridStateWithMines = buildInitialGrid();
    notifyListeners();
  }

  onTap(int x, int y) {
    if (gridStateWithMines[x][y] == '') {
      gridState[x][y] = '0';
    } else if (gridStateWithMines[x][y] == 'X') {
      lose = !lose;
      started = false;
      print("[$x][$y] contains mine. lose? $lose");
      gridState[x][y] = 'X';
      gridStateWithMines[x][y] = 'X';
      mergeGrids();
    }
    print("tapped: $x $y");

    if (!started) {
      started = true;
      putMines();
      print("game started!!");
    }
    played++;
    score++;
    notifyListeners();
  }

  isOpen(int row, int col) {
    bool contains = (game != null && game[row][col] == 0);
    return contains;
  }

  containsMine(int row, int col) {
    bool contains = (game != null && game[row][col] == 9);
    return contains;
  }

  putMines() {
    gridState = buildInitialGrid();
    gridStateWithMines = buildInitialGrid();
    _clean(gridStateWithMines);
    for (var i = 0; i < mines; i++) {
      int randomRowIndex;
      int randomColumnIndex;

      do {
        randomRowIndex = _random(0, rows - 1);
        randomColumnIndex = _random(0, columns - 1);
      } while (gridState[randomRowIndex][randomColumnIndex] == 'X');

      gridStateWithMines[randomRowIndex][randomColumnIndex] = 'X';
    }
  }

  _clean(List<List<String>> gridState) {
    if (gridState == null) return;
    for (var i = 0; i < rows; i++) {
      for (var j = 0; j < columns; j++) {
        gridState[i][j] = '';
      }
    }
  }

  // buildGameTable() {
  //   print("buildGameTable");
  //   var rowsItems = List<TableRow>.filled(rows, null);
  //   for (var i = 0; i < rows; i++) {
  //     rowsItems[i] = TableRow(
  //       children: buildItems(i, columns),
  //     );
  //   }
  //   gameTable = Table(
  //     children: rowsItems,
  //   );
  // }

  // List<Widget> buildItems(int rowIndex, int length) {
  //   List<Widget> widgets = List<Widget>.filled(length, null);

  //   for (var i = 0; i < length; i++) {
  //     widgets[i] = AreaItem(
  //       rowPosition: rowIndex,
  //       colPosition: i,
  //       content: ((game != null) ? game[rowIndex][i] : null),
  //     );
  //   }
  //   return widgets;
  // }

  int _random(int min, int max) {
    Random rnd;
    int min = 0;
    rnd = new Random();
    var result = min + rnd.nextInt(max - min);
    return result;
  }

  List<List<String>> buildInitialGrid() {
    return List.generate(rows, (i) => List.generate(columns, (j) => ""));
  }

  void mergeGrids() {
    for (var i = 0; i < 16; i++) {
      for (var j = 0; j < 16; j++) {
        if (gridStateWithMines[i][j] == 'X') {
          gridState[i][j] = gridStateWithMines[i][j];
        }
      }
    }
  }
}
