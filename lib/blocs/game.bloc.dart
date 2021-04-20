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
  bool win = false;
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
      for (int j = 0; j < columns; j++) {
        if (gridStateWithMines[i][j] == hasMine) {
          fillAdjacents(i, j);
        }
      }
    }

    print("------------------ game with bombs and tips start-----------------");
    printGridWithMines();
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
      expand(x, y);
    } else if (gridStateWithMines[x][y] == hasMine) {
      loseGame(x, y);
    } else {
      gridState[x][y] = gridStateWithMines[x][y];
    }

    played++;
    score++;

    if (mines == 0) {
      verifyResult();
    }
    notifyListeners();
  }

  void onLongPress(int x, int y) {
    if (!started) {
      putMines();
      start();
    }
    print("long press: $x $y");
    gridState[x][y] = hasFlag;
    mines--;

    played++;
    score++;

    if (mines == 0) {
      print("mines: $mines");
      verifyResult();
    }
    notifyListeners();
  }

  void expand(int x, int y) {
    moveUp(x, y);
    moveDown(x, y);
  }

  void moveUp(int x, int y) {
    bool reachEnd = false;
    int line = x;
    while ((!reachEnd) && line >= 0) {
      print("moving up line: $line");
      if (gridStateWithMines[line][y] is int) {
        gridState[line][y] = gridStateWithMines[line][y];
        reachEnd = true;
      } else if (gridState[line][y] == hasFlag) {
        reachEnd = true;
      }
      moveRight(line, y);
      moveLeft(line, y);
      line--;
    }
  }

  void moveDown(int x, int y) {
    bool reachEnd = false;
    int line = x;
    while ((!reachEnd) && line < rows) {
      if (gridStateWithMines[line][y] is int) {
        gridState[line][y] = gridStateWithMines[line][y];
        reachEnd = true;
      } else if (gridState[line][y] == hasFlag) {
        reachEnd = true;
      }
      moveRight(line, y);
      moveLeft(line, y);
      line++;
    }
  }

  void moveRight(int x, int y) {
    bool keepForwarding = true;
    int i = y;
    while (keepForwarding) {
      if (i == columns - 1) {
        keepForwarding = false;
      }
      if (gridStateWithMines[x][i] == empty) {
        gridState[x][i] = opened;
      } else if (gridStateWithMines[x][i] is int) {
        gridState[x][i] = gridStateWithMines[x][i];
      } else if (gridState[x][i] == hasMine) {
        keepForwarding = false;
      } else if (gridState[x][i] == hasFlag) {
        keepForwarding = false;
      }
      i++;
    }
  }

  void moveLeft(int x, int y) {
    bool keepForwarding = true;
    int i = y;
    while (keepForwarding) {
      if (i == 0) {
        keepForwarding = false;
      }
      if (gridStateWithMines[x][i] == empty) {
        gridState[x][i] = opened;
      } else if (gridStateWithMines[x][i] is int) {
        gridState[x][i] = gridStateWithMines[x][i];
      } else if (gridState[x][i] == hasMine) {
        keepForwarding = false;
      } else if (gridState[x][i] == hasFlag) {
        keepForwarding = false;
      }
      i--;
    }
  }

  void loseGame(int x, int y) {
    lose = true;
    started = false;
    gridState[x][y] = hasMine;
    gridStateWithMines[x][y] = hasMine;
    _mergeGrids();
    timer.cancel();
  }

  void loseRound() {
    lose = true;
    started = false;
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
    mines = 30;
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

  void verifyResult() {
    print("verifyResult.");
    bool winRound = false;
    // verifica se os numeros e vazios estão iguais ao gabarito...
    for (var i = 0; i < rows; i++) {
      for (var j = 0; j < columns; j++) {
        if ((gridState[i][j] == hasFlag) &&
            (gridStateWithMines[i][j] == hasMine)) {
          // flags and mines are equal. Win!
          winRound = true;
          print("verifyResult Win!.");
        }
      }
    }
    win = winRound;
    if (!win) {
      loseRound();
      return;
    }
    win = true;
    print("verifyResult Win?!: $win");
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

  void fillAdjacents(int x, int y) {
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

  void printGridWithMines() {
    for (int i = 0; i < rows; i++) {
      String currentLine = "";
      for (int j = 0; j < columns; j++) {
        currentLine += " ${gridStateWithMines[i][j]}";
      }
      print(currentLine);
    }
  }
}
