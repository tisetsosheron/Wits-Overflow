import 'package:flutter/material.dart';
import 'package:wits_overflow/Pages/homepage.dart';
import 'package:wits_overflow/Pages/register.dart';
import 'package:wits_overflow/Pages/signin.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key, required bool showLogin});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //Showing the Login Page
  bool showLogin = true;
  void togglePages() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    //if user is registered show login page
    if (showLogin) {
      return LoginPage(
        onTap: togglePages,
      );
      //else  show register page
    } else {
      return Register(
        onTap: togglePages,
      );
    }
  }
}
