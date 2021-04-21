import 'package:flutter_test/flutter_test.dart';

import 'package:minesweeper/blocs/game.bloc.dart';

void main() {
  var gameBloc = GameBloc();

  group('GameBloc Test', () {
    test("Call to 'onTap' gonna create two Grids for the Game", () {
      int x = 5;
      int y = 5;
      gameBloc.onTap(x, y);
      expect(gameBloc.gridState.length, 16);
      expect(gameBloc.gridStateWithMines.length, 16);
    });

    test("Call to 'expand' gonna open expected Squares", () {});
  });
}
