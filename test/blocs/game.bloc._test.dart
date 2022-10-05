import 'package:flutter_test/flutter_test.dart';

import 'package:minesweeper/blocs/game.bloc.dart';

void main() {
  var gameBloc = GameBloc();

  group('GameBloc Test', () {
    test(
        "Should create two Grids 10x10 for the Game when 'onTap' is called for Easy level",
        () {
      gameBloc.select(Level.EASY);
      expect(gameBloc.gridState.length, 10);
      expect(gameBloc.gridStateWithMines.length, 10);
    });

    test(
        "Should create two Grids 16x16 for the Game when 'onTap' is called for Medium level",
        () {
      gameBloc.select(Level.MEDIUM);
      expect(gameBloc.gridState.length, 16);
      expect(gameBloc.gridStateWithMines.length, 16);
    });

    test(
        "Should create two Grids 24x24 for the Game when 'onTap' is called for Hard level",
        () {
      gameBloc.select(Level.HARD);
      expect(gameBloc.gridState.length, 24);
      expect(gameBloc.gridStateWithMines.length, 24);
    });

    test(
        "Should create two Grids 30x30 for the Game when 'onTap' is called for Hard2 level",
        () {
      gameBloc.select(Level.HARD2);
      expect(gameBloc.gridState.length, 30);
      expect(gameBloc.gridStateWithMines.length, 30);
    });
  });
}
