import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper/widgets/version_footer.widget.dart';

void main() {
  testWidgets('VersionFooter widget displays version text', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: VersionFooter(),
        ),
      ),
    );

    // Initially should show a version text (either loaded version or fallback)
    await tester.pump(); // Initial build
    await tester.pump(Duration(seconds: 1)); // Give time for async load

    // Should find some version text - either the actual version or the fallback "v1.0.0"
    expect(find.textContaining('v'), findsOneWidget);
  });

  testWidgets('VersionFooter widget has correct styling', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: VersionFooter(),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(Duration(seconds: 1));

    // Find the container with padding
    expect(find.byType(Container), findsOneWidget);
    
    // Find the text widget
    expect(find.byType(Text), findsOneWidget);
    
    // Verify text is center aligned
    final Text textWidget = tester.widget(find.byType(Text));
    expect(textWidget.textAlign, TextAlign.center);
    expect(textWidget.style?.fontSize, 12);
    expect(textWidget.style?.fontFamily, 'TickingTimebombBB');
  });
}