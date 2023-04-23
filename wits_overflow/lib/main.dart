import 'package:flutter/material.dart';
import 'package:wits_overflow/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wits_overflow/questions.dart';
import 'package:wits_overflow/register.dart';
import 'fetch_questions.dart';
import 'questions.dart';
import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuestionListWidget(),
    );
  }
}
