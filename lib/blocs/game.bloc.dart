import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minesweeper/blocs/game.config.dart';
// import 'package:minesweeper/blocs/game.config.dart';

const String EASY = "EASY";
const String MEDIUM = "MEDIUM";
const String HARD = "HARD";

// Square Values
const String empty = "-";
const String hasMine = "X";
const String hasFlag = "F";
const String opened = "0";

class GameBloc extends ChangeNotifier {
  Timer timer;
  double seconds = 0;
  int played = 0;
  int score = 0;
  bool lose = false;
  bool started = false;
  bool win = false;
  List<List<dynamic>> gridState;
  List<List<dynamic>> gridStateWithMines;

  int rows = 16;
  int columns = 16;
  int mines = 30;

  select(String level) {
    switch (level) {
      case EASY:
        started = false;
        rows = easyRows;
        columns = easyColumns;
        mines = easyMines;
        createGrids();
        notifyListeners();
        break;
      case MEDIUM:
        started = false;
        rows = mediumRows;
        columns = mediumColumns;
        mines = mediumMines;
        createGrids();
        notifyListeners();
        break;
      case HARD:
        started = false;
        rows = hardRows;
        columns = hardColumns;
        mines = hardMines;
        createGrids();
        notifyListeners();
        break;
      default:
        started = false;
        rows = mediumRows;
        columns = mediumColumns;
        mines = mediumMines;
        createGrids();
        notifyListeners();
        break;
    }
  }

  void createGrids() {
    gridState =
        List.generate(rows, (i) => List.generate(columns, (j) => empty));
    gridStateWithMines =
        List.generate(rows, (i) => List.generate(columns, (j) => empty));
  }

  putMines() {
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

    print("mines: $mines");
    if (mines == 0) {
      verifyResult();
    }
    notifyListeners();
  }

  void expand(int x, int y) {
    moveRight(x, y);
    moveLeft(x, y);
    moveUp(x, y);
    moveDown(x, y);
  }

  void moveUp(int x, int y) {
    bool reachEnd = false;
    int line = x;
    while ((!reachEnd) && line >= 0) {
      print("moving up line: $line");
      moveRight(line, y);
      moveLeft(line, y);

      if (gridStateWithMines[line][y] is int) {
        gridState[line][y] = gridStateWithMines[line][y];
        reachEnd = true;
      } else if (gridState[line][y] == hasFlag) {
        reachEnd = true;
      }
      line--;
    }
  }

  void moveDown(int x, int y) {
    bool reachEnd = false;
    int line = x;
    while ((!reachEnd) && line < rows) {
      var actual = gridStateWithMines[line][y];
      moveRight(line, y);
      moveLeft(line, y);

      if (actual is int) {
        gridState[line][y] = gridStateWithMines[line][y];
        reachEnd = true;
      } else if (gridState[line][y] == hasFlag) {
        reachEnd = true;
      }
      line++;
    }
  }

  void moveRight(int x, int y) {
    print("moveRight $x $y");
    bool keepForwarding = true;
    int i = y;
    while (keepForwarding) {
      if (i == columns - 1) {
        keepForwarding = false;
      }
      var actual = gridStateWithMines[x][i];
      var previous = (i - 1 >= 0) ? gridStateWithMines[x][i - 1] : '';
      if (actual == empty) {
        gridState[x][i] = opened;
      } else if (actual is int &&
          ((previous is int) || (previous == hasMine))) {
        keepForwarding = false;
      } else if (actual is int) {
        gridState[x][i] = gridStateWithMines[x][i];
      } else if (actual == hasMine) {
        keepForwarding = false;
      } else if (actual == hasFlag) {
        keepForwarding = false;
      }
      verifyUpAndDown(x, i);
      i++;
    }
  }

  void moveLeft(int x, int y) {
    print("moveLeft $x $y");
    bool keepForwarding = true;
    int i = y;
    while (keepForwarding) {
      if (i == 0) {
        keepForwarding = false;
      }
      var actual = gridStateWithMines[x][i];
      var previous = (i + 1 >= 0) ? gridStateWithMines[x][i + 1] : '';
      if (actual == empty) {
        gridState[x][i] = opened;
      } else if (actual is int &&
          ((previous is int) || (previous == hasMine))) {
        keepForwarding = false;
      } else if (actual is int) {
        gridState[x][i] = gridStateWithMines[x][i];
      } else if (actual == hasMine) {
        keepForwarding = false;
      } else if (actual == hasFlag) {
        keepForwarding = false;
      }
      verifyUpAndDown(x, i);
      i--;
    }
  }

  void verifyUpAndDown(int x, int y) {
    print("verifyUpAndDown: $x $y");
    if ((x - 1) >= 1) {
      var actual = gridStateWithMines[x - 1][y];
      if (actual == empty) {
        gridStateWithMines[x - 1][y] = opened;
      } else if (gridStateWithMines[x - 1][y] is int) {
        gridState[x - 1][y] = gridStateWithMines[x - 1][y];
      }
    }
    if ((x + 1) < rows) {
      var actual = gridStateWithMines[x + 1][y];
      if (actual == empty) {
        gridStateWithMines[x + 1][y] = opened;
      } else if (gridStateWithMines[x + 1][y] is int) {
        gridState[x + 1][y] = gridStateWithMines[x + 1][y];
      }
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

  void winRound() {
    win = true;
    lose = false;
    started = false;
    _mergeGridsForWinRound();
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

  updateTime() {
    seconds++;
    notifyListeners();
  }

  restart() {
    print("restart called...");
    played = 0;
    score = 0;
    seconds = 0;
    lose = false;
    started = false;
    win = false;
    if (timer != null) timer.cancel();
    gridState =
        List.generate(rows, (i) => List.generate(columns, (j) => empty));
    gridStateWithMines =
        List.generate(rows, (i) => List.generate(columns, (j) => empty));
    print("restart finished...");
    notifyListeners();
  }

  void verifyResult() {
    print("verifyResult.");
    bool checkRound = false;
    // verifica se os numeros e vazios estão iguais ao gabarito...
    for (var i = 0; i < rows; i++) {
      for (var j = 0; j < columns; j++) {
        if ((gridState[i][j] == hasFlag) &&
            (gridStateWithMines[i][j] == hasMine)) {
          checkRound = true;
        } else if ((gridState[i][j] == opened) &&
            (gridStateWithMines[i][j] == empty)) {
          checkRound = true;
        }
      }
    }
    if (!checkRound) {
      loseRound();
      print("verifyResult Win?!: $win");
    } else {
      winRound();
      print("verifyResult Win?!: $win");
    }
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

  void _mergeGridsForWinRound() {
    for (var i = 0; i < rows; i++) {
      for (var j = 0; j < columns; j++) {
        if (gridStateWithMines[i][j] == hasMine) {
          gridState[i][j] = hasFlag;
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
