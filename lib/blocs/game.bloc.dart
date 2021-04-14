import 'dart:math';

import 'package:flutter/material.dart';

class GameBloc extends ChangeNotifier {
  int played = 0;
  int score = 0;
  bool lose = false;
  bool started = false;
  int x; // rows
  int y; // columns
  int mines; // mines
  List<List<String>> gridState;
  List<List<String>> gridStateWithMines;

  GameBloc() {
    this.x = 16;
    this.y = 16;
    this.mines = 26;
    gridState = List.generate(x, (i) => List.generate(y, (j) => ""));
    gridStateWithMines = List.generate(x, (i) => List.generate(y, (j) => ""));
  }

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
        randomRowIndex = _random(0, x);
        randomColumnIndex = _random(0, y);
      } while (gridState[randomRowIndex][randomColumnIndex] == 'X');

      gridStateWithMines[randomRowIndex][randomColumnIndex] = 'X';
    }
  }

  void onTap(int x, int y) {
    if (!started) {
      started = true;
    }
    // print("tapped: $x $y");
    if (gridStateWithMines[x][y] == '') {
      gridState[x][y] = '0';
    } else if (gridStateWithMines[x][y] == 'X') {
      loseGame(x, y);
    }
    played++;
    score++;
    notifyListeners();
  }

  void loseGame(int x, int y) {
    lose = true;
    gridState[x][y] = 'X';
    gridStateWithMines[x][y] = 'X';
    _mergeGrids();
  }

  restart() {
    played = 0;
    score = 0;
    lose = false;
    started = false;
    gridState = List.generate(x, (i) => List.generate(y, (j) => ""));
    gridStateWithMines = List.generate(x, (i) => List.generate(y, (j) => ""));
    putMines();
    notifyListeners();
  }

  void _mergeGrids() {
    for (var i = 0; i < x; i++) {
      for (var j = 0; j < y; j++) {
        if (gridStateWithMines[i][j] == 'X') {
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
}
