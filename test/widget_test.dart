import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wits_overflow/homepage.dart';
import 'package:wits_overflow/signin.dart';

//testing the login page
void main() {
  testWidgets('Test login page', (WidgetTester tester) async {
    // Find the email and password text fields.
    final emailField = find.widgetWithText(TextField, 'Email');
    final passwordField = find.widgetWithText(TextField, 'Password');
    // Tap the sign in button.
    final signInButton = find.widgetWithText(GestureDetector, 'Sign In');

    // Build the LoginPage widget.
    await tester.pumpWidget(LoginPage(
      onTap: () {},
    ));
    // Wait for the dialog to disappear.
    await tester.pumpAndSettle();
    // Wait for the dialog to appear.
    await tester.pump();

    // Enter text into the email and password fields.
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'password');
    await tester.tap(signInButton);

    // Test that the email and password fields are initially empty.
    expect((emailField.evaluate().single.widget as TextField).controller!.text,
        '');
    expect(
        (passwordField.evaluate().single.widget as TextField).controller!.text,
        '');

    // Test that the text was entered correctly.
    expect((emailField.evaluate().single.widget as TextField).controller!.text,
        'test@example.com');
    expect(
        (passwordField.evaluate().single.widget as TextField).controller!.text,
        'password');

    // Test that the dialog is displayed.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Test that the user is navigated to the Dashboard page.
    expect(find.byType(Dashboard), findsOneWidget);
  });
}
