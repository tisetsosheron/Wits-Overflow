import 'package:flutter/material.dart';
import 'package:wits_overflow/Pages/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wits_overflow/Pages/register.dart';
import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyD_WpxhL7-ELc8sELvPCWNv3PHTSKgSiLU",
          appId: "1:259209096667:android:f765544fd72981a94a4bfe",
          messagingSenderId: "",
          projectId: "fir-login-e8376"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
