import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wits_overflow/Pages/MainQuestions.dart';

void main() {
  // Initialize Firebase before running the tests
  // setUpAll(() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp();
  // });

  group('CounterScreen', () {
    testWidgets('should render correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: CounterScreenState()));

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(IconButton).first, findsOneWidget,
          reason: 'There should be exactly one IconButton');
    });

    // testWidgets('should post question when button is pressed',
    //     (WidgetTester tester) async {
    //   await tester.pumpWidget(MaterialApp(home: CounterScreenState()));

    //   final questionController = TextEditingController();
    //   questionController.text = 'This is a question';

    //   await tester.enterText(find.byType(TextField), questionController.text);
    //   await tester.tap(find.byType(IconButton).first);
    //   await tester.pumpAndSettle();

    //   final questions =
    //       await FirebaseFirestore.instance.collection('questions').get();

    //   expect(questions.docs.length, equals(1));
    //   expect(questions.docs.first['question'], equals('This is a question'));
    // });

    // testWidgets(
    //     'should not post question when button is pressed with empty question',
    //     (WidgetTester tester) async {
    //   await tester.pumpWidget(MaterialApp(home: CounterScreenState()));

    //   final questionController = TextEditingController();
    //   questionController.text = '';

    //   await tester.enterText(find.byType(TextField), questionController.text);
    //   await tester.tap(find.byType(IconButton).first);
    //   await tester.pumpAndSettle();

    //   final questions =
    //       await FirebaseFirestore.instance.collection('questions').get();

    //   expect(questions.docs.length, equals(0));
    // });
  });
}
