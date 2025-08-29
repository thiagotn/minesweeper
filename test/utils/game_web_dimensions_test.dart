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

    test('calculateGameWebWidth uses 3-column layout logic for very wide screens', () {
      // Create very wide constraints (simulating 1920x1080)
      const veryWideConstraints = BoxConstraints(
        minWidth: 0,
        maxWidth: 1920,
        minHeight: 0,
        maxHeight: 1080,
      );
      
      final bloc = GameBloc();
      bloc.select(Level.MEDIUM);
      
      final width = GameWebDimensions.calculateGameWebWidth(veryWideConstraints, bloc);
      
      // For very wide screens (>=1200px), should use middle column logic
      // Middle column should be roughly 1/3 of screen width, clamped between 400-800
      final expectedMiddleColumnWidth = (veryWideConstraints.maxWidth / 3).clamp(400.0, 800.0);
      
      // Width should be reasonable for the middle column
      expect(width, greaterThan(0));
      expect(width, lessThan(expectedMiddleColumnWidth));
    });

    test('calculateGameWebWidth uses standard logic for medium wide screens', () {
      // Create medium wide constraints (between 800-1199px)
      const mediumWideConstraints = BoxConstraints(
        minWidth: 0,
        maxWidth: 1000,
        minHeight: 0,
        maxHeight: 800,
      );
      
      final bloc = GameBloc();
      bloc.select(Level.EASY);
      
      final width = GameWebDimensions.calculateGameWebWidth(mediumWideConstraints, bloc);
      
      // For medium wide screens (<1200px), should use standard 90% logic
      expect(width, greaterThan(0));
      expect(width, lessThan(mediumWideConstraints.maxWidth * 0.9));
    });
  });
}