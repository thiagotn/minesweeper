import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minesweeper/blocs/game.config.dart';

class GameBloc extends ChangeNotifier {
  Timer timer;
  double seconds = 0;
  int played = 0;
  int score = 0;
  bool lose = false;
  bool started = false;
  // Default
  int rows = 16;
  int columns = 16;
  int mines = 30;
  List<List<dynamic>> gridState;
  List<List<dynamic>> gridStateWithMines;

  GameBloc() {
    gridState =
        List.generate(rows, (i) => List.generate(columns, (j) => empty));
    gridStateWithMines =
        List.generate(rows, (i) => List.generate(columns, (j) => empty));
  }

  List<List<dynamic>> clean(List<List<dynamic>> gridState) {
    for (var i = 0; i < rows; i++) {
      for (var j = 0; j < columns; j++) {
        gridState[i][j] = empty;
      }
    }
    return gridState;
  }

  putMines() {
    clean(gridStateWithMines);
    for (int i = 0; i < mines; i++) {
      int randomRowIndex;
      int randomColumnIndex;

      do {
        randomRowIndex = _random(0, rows);
        randomColumnIndex = _random(0, columns);
      } while (
          gridStateWithMines[randomRowIndex][randomColumnIndex] == hasMine);

      gridStateWithMines[randomRowIndex][randomColumnIndex] = hasMine;
    }

    // print("------------------ game with bombs start-----------------");
    // printGrid();
    // print("------------------ game with bombs end-----------------");

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < rows; j++) {
        if (gridStateWithMines[i][j] == hasMine) {
          expand(i, j);
        }
      }
    }

    print("------------------ game with bombs and tips start-----------------");
    printGrid();
    print("------------------ game with bombs and tips ended-----------------");
  }

  void onTap(int x, int y) {
    if (!started) {
      putMines();
      start();
    }
    print("tapped: $x $y");
    if (gridStateWithMines[x][y] == empty) {
      gridState[x][y] = opened;
    } else if (gridStateWithMines[x][y] == hasMine) {
      loseGame(x, y);
    } else {
      print("else case....${gridStateWithMines[x][y]}");
      gridState[x][y] = gridStateWithMines[x][y];
    }
    played++;
    score++;
    notifyListeners();
  }

  void loseGame(int x, int y) {
    lose = true;
    started = false;
    gridState[x][y] = hasMine;
    gridStateWithMines[x][y] = hasMine;
    _mergeGrids();
    timer.cancel();
  }

  start() {
    started = true;
    timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer t) => updateTime(),
    );
    notifyListeners();
  }

  restart() {
    played = 0;
    score = 0;
    seconds = 0;
    lose = false;
    started = false;
    gridState =
        List.generate(rows, (i) => List.generate(columns, (j) => empty));
    gridStateWithMines =
        List.generate(rows, (i) => List.generate(columns, (j) => empty));
    putMines();
    notifyListeners();
  }

  updateTime() {
    seconds++;
    notifyListeners();
  }

  void _mergeGrids() {
    for (var i = 0; i < rows; i++) {
      for (var j = 0; j < columns; j++) {
        if (gridStateWithMines[i][j] == hasMine) {
          gridState[i][j] = gridStateWithMines[i][j];
        }
      }
    }
  }

  int _random(int min, int max) {
    Random rnd;
    int min = 0;
    rnd = new Random();
    var result = min + rnd.nextInt(max - min);
    return result;
  }

  void recalculateAdjacents(int x, int y) {
    if ((x < 0 || y < 0) || (x > rows - 1 || y > columns - 1)) {
      print("invalid index: [$x][$y]");
      return;
    }

    var targetValue = gridStateWithMines[x][y];
    if (targetValue == empty) {
      gridStateWithMines[x][y] = 1;
    } else if (targetValue != hasMine) {
      gridStateWithMines[x][y] = gridStateWithMines[x][y] + 1;
    }
  }

  void expand(int x, int y) {
    recalculateAdjacents(x, y);
    recalculateAdjacents(x, y - 1); // left; 10
    recalculateAdjacents(x, y + 1); // right; 12

    recalculateAdjacents(x - 1, y); // top; 01
    recalculateAdjacents(x - 1, y - 1); // topLeft; 00
    recalculateAdjacents(x - 1, y + 1); // topRight; 02

    recalculateAdjacents(x + 1, y); // bottom; 21
    recalculateAdjacents(x + 1, y - 1); // bottomLeft; 20
    recalculateAdjacents(x + 1, y + 1); // bottomRight; 22
  }

  void printGrid() {
    for (int i = 0; i < rows; i++) {
      String currentLine = "";
      for (int j = 0; j < columns; j++) {
        currentLine += " ${gridStateWithMines[i][j]}";
      }
      print(currentLine);
    }
  }
}
