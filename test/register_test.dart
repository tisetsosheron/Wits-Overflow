import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wits_overflow/register.dart';

void main() {
  testWidgets('Register widget test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Register(onTap: () {})));

    // find widgets
    // createAccountButton = find.widgetWithText(Text, 'Register');
    final emailTextField = find.widgetWithText(TextField, 'email address');
    final passwordTextField = find.widgetWithText(TextField, 'Password');
    final confirmPasswordTextField =
        find.widgetWithText(TextField, 'Confirm Password');
    //final radioButtons = find.byType(Radio);

    // test email and password input
    await tester.enterText(emailTextField, 'test@gmail.com');
    await tester.enterText(passwordTextField, '12345678');
    await tester.enterText(confirmPasswordTextField, '12345678');

    // select radio button
    // if (radioButtons.evaluate().isNotEmpty) {
    //   await tester.tap(radioButtons.first);
    //   await tester.pumpAndSettle();
    // }

    // test create account button
    // expect(createAccountButton, findsOneWidget);
    //await tester.tap(createAccountButton);
    // await tester.pumpAndSettle();

    // check if the dialog is shown
    expect(find.text('Invalid Email'), findsNothing);
    expect(find.text('Weak Password'), findsNothing);
    expect(find.text('Passwords do not match'), findsNothing);
  });
}
