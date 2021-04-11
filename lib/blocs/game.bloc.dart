import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

class GameBloc extends ChangeNotifier {
  int played = 0;
  int score = 0;
  bool lose = false;
  bool started = false;

  int rows = 16;
  int columns = 16;
  int mines = 26;
  var game;

  start() {
    played = 0;
    score = 0;
    lose = false;
    started = true;
    putMines();
    notifyListeners();
  }

  restart() {
    played = 0;
    score = 0;
    lose = false;
    started = true;
    putMines();
    notifyListeners();
  }

  onTap(int row, int col) {
    if (!started) {
      started = true;
      putMines();
      print("game started!!");
    }
    if (containsMine(row, col)) {
      lose = !lose;
      started = false;
      print("[$row][$col] contains mine. lose? $lose");
    }
    played++;
    score++;
    notifyListeners();
  }

  containsMine(int row, int col) {
    bool contains = (game != null && game[row][col] == 9);
    // print("game[$row][$col] contains mine? $contains");
    return contains;
  }

  putMines() {
    game = List.generate(rows, (i) => List(columns), growable: false);
    for (var i = 0; i < mines; i++) {
      int randomRowIndex;
      int randomColumnIndex;

      do {
        randomRowIndex = _random(0, rows - 1);
        randomColumnIndex = _random(0, columns - 1);
      } while (game[randomRowIndex][randomColumnIndex] == 9);

      game[randomRowIndex][randomColumnIndex] = 9;
    }
    _printGame();
  }

  int _random(int min, int max) {
    Random rnd;
    int min = 0;
    rnd = new Random();
    var result = min + rnd.nextInt(max - min);
    return result;
  }

  _printGame() {
    for (var i = 0; i < rows; i++) {
      for (var j = 0; j < columns; j++) {
        stdout.write("${game[i][j]} ");
      }
      print("");
    }
  }
}
