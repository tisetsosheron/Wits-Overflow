import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wits_overflow/Pages/login_or_register.dart';
import 'package:wits_overflow/Pages/register.dart';
import 'package:wits_overflow/Pages/signin.dart';

void main() {
  testWidgets('should show LoginPage when showLogin is true',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: LoginOrRegister(showLogin: true)));

    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.byType(Register), findsNothing);
  });

  // testWidgets('should show Register when showLogin is false',
  //     (WidgetTester tester) async {
  //   await tester
  //       .pumpWidget(MaterialApp(home: LoginOrRegister(showLogin: false)));

  //   expect(find.byType(Register), findsOneWidget);
  //   expect(find.byType(LoginPage), findsNothing);

  //   final registerWidget = tester.widget<Register>(find.byType(Register));
  //   expect(registerWidget, isNotNull);
  // });

  // testWidgets(
  //     'should toggle between LoginPage and Register when onTap is called',
  //     (WidgetTester tester) async {
  //   await tester
  //       .pumpWidget(MaterialApp(home: LoginOrRegister(showLogin: true)));

  //   expect(find.byType(LoginPage), findsOneWidget);
  //   expect(find.byType(Register), findsNothing);

  //   await tester.tap(find.byKey(const Key('toggle-pages')));
  //   await tester.pump();

  //   expect(find.byType(Register), findsOneWidget);
  //   expect(find.byType(LoginPage), findsNothing);

  //   await tester.tap(find.byKey(const Key('toggle-pages')));
  //   await tester.pump();

  //   expect(find.byType(LoginPage), findsOneWidget);
  //   expect(find.byType(Register), findsNothing);
  // });
}
