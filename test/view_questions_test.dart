import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wits_overflow/ViewQuestions.dart';

void main() {
  group('ViewQuestions', () {
    testWidgets('Renders AppBar correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ViewQuestions(),
        ),
      );

      // Verify that the app bar contains the correct text
      expect(find.text('Wits Overflow'), findsOneWidget);
    });

    testWidgets('Toggles search mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ViewQuestions(),
        ),
      );

      // Verify that the search mode is initially false
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byType(TextField), findsNothing);

      // Tap the search icon
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Verify that the search mode is now true
      expect(find.byIcon(Icons.cancel),
          findsOneWidget); // Update the expected icon to Icons.cancel
      expect(find.byType(TextField), findsOneWidget);

      // Tap the cancel icon
      await tester.tap(find.byIcon(Icons.cancel));
      await tester.pumpAndSettle();

      // Verify that the search mode is false again
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byType(TextField), findsNothing);
    });

    // testWidgets('Navigates to Dashboard', (WidgetTester tester) async {
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: ViewQuestions(),
    //     ),
    //   );

    //   // Tap the home icon
    //   await tester.tap(find.byIcon(Icons.home));
    //   await tester.pumpAndSettle();

    //   // Verify that the Dashboard page is displayed
    //   expect(find.byType(Dashboard), findsOneWidget);
    // });

    // Add more tests for other functionality as needed
  });
}
