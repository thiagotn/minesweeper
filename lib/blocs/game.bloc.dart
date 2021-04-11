import 'package:flutter/material.dart';

class GameBloc extends ChangeNotifier {
  int played = 0;
  int score = 0;
  bool lose = false;
  bool started = false;

  restart() {
    played = 0;
    score = 0;
    lose = false;
    started = false;
    notifyListeners();
  }

  onTap(int row, int col) {
    if (!started) {
      started = true;
    }
    if (row == 0 && col == 0) {
      lose = !lose;
      started = false;
    }
    played++;
    score++;
    notifyListeners();
  }
}
