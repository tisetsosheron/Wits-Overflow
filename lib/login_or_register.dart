import 'package:flutter/material.dart';
import 'package:wits_overflow/register.dart';
import 'package:wits_overflow/signin.dart';

class LoginOrRegister extends StatefulWidget {
  final bool showLogin;

  const LoginOrRegister({Key? key, required this.showLogin}) : super(key: key);

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLogin = true;

  @override
  void initState() {
    super.initState();
    showLogin = widget.showLogin;
  }

  void togglePages() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return LoginPage(
        key: const Key('toggle-pages'),
        onTap: togglePages,
      );
    } else {
      return Register(
        key: const Key('toggle-pages'),
        onTap: togglePages,
      );
    }
  }
}
