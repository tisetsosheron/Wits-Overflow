/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wits_overflow/register.dart';
import 'package:wits_overflow/signin.dart';

import 'ResetPassword.dart';
import 'homepage.dart';

void main() {
  // Tests for LoginPage widget
  group('LoginPage', () {
    // Test case: Verify that the sign-in process works with valid credentials
    testWidgets('Sign in with valid credentials', (WidgetTester tester) async {
      // Set up the widget under test
      final page = LoginPage(onTap: () {});
      await tester.pumpWidget(MaterialApp(home: page));

      // Fill in the email and password fields with valid credentials
      await tester.enterText(
          find.byType(TextField).at(0), 'example@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'password');

      // Tap the sign-in button
      await tester.tap(find.text('Sign In'));
      await tester.pump();

      // Verify that the user is signed in and is taken to the Dashboard page
      expect(FirebaseAuth.instance.currentUser, isNotNull);
      expect(find.byType(Dashboard), findsOneWidget);
    });

    // Test case: Verify that the sign-in process fails with invalid credentials
    testWidgets('Sign in with invalid credentials',
        (WidgetTester tester) async {
      // Set up the widget under test
      final page = LoginPage(onTap: () {});
      await tester.pumpWidget(MaterialApp(home: page));

      // Fill in the email and password fields with invalid credentials
      await tester.enterText(
          find.byType(TextField).at(0), 'invalid@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'password');

      // Tap the sign-in button
      await tester.tap(find.text('Sign In'));
      await tester.pump();

      // Verify that the user is not signed in and an error message is displayed
      expect(FirebaseAuth.instance.currentUser, isNull);
      expect(find.text('Invalid email or password'), findsOneWidget);
    });

    // Test case: Verify that the "Forgot password?" button opens the ResetPassword page
    testWidgets('Open ResetPassword page', (WidgetTester tester) async {
      // Set up the widget under test
      final page = LoginPage(onTap: () {});
      await tester.pumpWidget(MaterialApp(home: page));

      // Tap the "Forgot password?" button
      await tester.tap(find.text('Forgot password?'));
      await tester.pump();

      // Verify that the ResetPassword page is displayed
      expect(find.byType(ResetPassword), findsOneWidget);
    });

    // Test case: Verify that the "Register now" button opens the Register page
    testWidgets('Open Register page', (WidgetTester tester) async {
      // Set up the widget under test
      final page = LoginPage(onTap: () {});
      await tester.pumpWidget(MaterialApp(home: page));

      // Tap the "Register now" button
      await tester.tap(find.text('Register now'));
      await tester.pump();

      // Verify that the Register page is displayed
      expect(find.byType(Register), findsOneWidget);
    });
  });
}*/
