import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper/blocs/game.bloc.dart';
import 'package:minesweeper/utils/game_web_dimensions.dart';

void main() {
  group('GameWebDimensions', () {
    test('calculateGameWebWidth returns expected width for typical constraints', () {
      // Create mock constraints (1200x800 - wide mode)
      const constraints = BoxConstraints(
        minWidth: 0,
        maxWidth: 1200,
        minHeight: 0,
        maxHeight: 800,
      );
      
      // Create a mock GameBloc with typical game dimensions
      final bloc = GameBloc();
      bloc.select(Level.EASY); // This should set columns and rows to typical values
      
      // Calculate width
      final width = GameWebDimensions.calculateGameWebWidth(constraints, bloc);
      
      // Verify width is reasonable (should be > 0 and < maxWidth)
      expect(width, greaterThan(0));
      expect(width, lessThan(constraints.maxWidth));
    });

    test('calculateGameWebWidth handles square size clamping', () {
      // Create constraints that would result in very small squares
      const smallConstraints = BoxConstraints(
        minWidth: 0,
        maxWidth: 200,
        minHeight: 0,
        maxHeight: 200,
      );
      
      final bloc = GameBloc();
      bloc.select(Level.HARD2); // Larger grid
      
      final width = GameWebDimensions.calculateGameWebWidth(smallConstraints, bloc);
      
      // Should still return a reasonable width even with small constraints
      expect(width, greaterThan(0));
      expect(width, lessThan(smallConstraints.maxWidth));
    });
    
    test('calculateGameWebWidth handles large constraints', () {
      // Create very large constraints
      const largeConstraints = BoxConstraints(
        minWidth: 0,
        maxWidth: 2000,
        minHeight: 0,
        maxHeight: 1500,
      );
      
      final bloc = GameBloc();
      bloc.select(Level.EASY);
      
      final width = GameWebDimensions.calculateGameWebWidth(largeConstraints, bloc);
      
      // Width should be reasonable, not excessively large due to square size clamping
      expect(width, greaterThan(0));
      // With clamping at 35.0 max square size, width shouldn't be enormous
      expect(width, lessThan(1000)); // Reasonable upper bound
    });
  });
}