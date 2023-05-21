import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wits_overflow/Pages/MainQuestions.dart';
import 'package:wits_overflow/Widgets/fetch_data.dart';

import '../Widgets/fetch_dates.dart';

class HistoryView extends StatefulWidget {
  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('questions')
        .orderBy('created', descending: true)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Questions History"),
      ),
      body: SafeArea(
          child: FutureBuilder(
        future: getDocId(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: docIDs.length,
            itemBuilder: (context, index) {
              return Card(
                  child: ListTile(
                title: getQuestion(documentId: docIDs[index]),
                trailing: getDates(documentId: docIDs[index]),
              ));
            },
          );
        },
      )),
    );
  }
}
