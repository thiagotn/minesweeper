import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper/blocs/game.bloc.dart';
import 'package:minesweeper/widgets/game/actions.widget.dart';
import 'package:provider/provider.dart';

void main() {
  group('GameActions Widget', () {
    testWidgets('should use horizontal padding when width is specified', (WidgetTester tester) async {
      // Create a test widget with specified width
      const testWidth = 300.0;
      final bloc = GameBloc();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Provider<GameBloc>(
            create: (_) => bloc,
            child: const Scaffold(
              body: GameActions(width: testWidth),
            ),
          ),
        ),
      );

      // Find the Padding widget
      final paddingFinder = find.byType(Padding);
      expect(paddingFinder, findsOneWidget);

      final padding = tester.widget<Padding>(paddingFinder);
      
      // Verify that padding is symmetric horizontal (8.0 left/right, 0.0 top/bottom)
      expect(padding.padding, const EdgeInsets.symmetric(horizontal: 8.0));
    });

    testWidgets('should use all-around padding when width is not specified', (WidgetTester tester) async {
      // Create a test widget without specified width
      final bloc = GameBloc();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Provider<GameBloc>(
            create: (_) => bloc,
            child: const Scaffold(
              body: GameActions(), // No width specified
            ),
          ),
        ),
      );

      // Find the Padding widget
      final paddingFinder = find.byType(Padding);
      expect(paddingFinder, findsOneWidget);

      final padding = tester.widget<Padding>(paddingFinder);
      
      // Verify that padding is all around (8.0 on all sides)
      expect(padding.padding, const EdgeInsets.all(8.0));
    });
  });
}