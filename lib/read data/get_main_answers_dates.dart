import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wits_overflow/PostAnswers/QuestionId.dart';
import 'package:wits_overflow/model/Question.dart';
import 'package:wits_overflow/model/answers.dart';

class getMainAnswersDates extends StatelessWidget {
  final String documentId;
  final String questionId;

  getMainAnswersDates({required this.documentId, required this.questionId});

  @override
  Widget build(BuildContext context) {
    CollectionReference mainanswer = FirebaseFirestore.instance
        .collection('mainquestions')
        .doc(questionId)
        .collection('answers');

    return FutureBuilder<DocumentSnapshot>(
        future: mainanswer.doc(documentId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text(DateFormat('MM/dd/yyyy')
                .format(data['created'].toDate()!)
                .toString());
          }
          return Text('loading...');
        }));
  }
}
