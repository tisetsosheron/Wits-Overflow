import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wits_overflow/Pages/homepage.dart';
import 'package:wits_overflow/Pages/signin.dart';

//this is the authorization page

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
        // The user is signed in, so return the dashboard.
          return Dashboard();
        } else {
        // The user is not signed in, so return the login page.
          return LoginPage(onTap: () {});
        }
      },
    ));
  }
}
