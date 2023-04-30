import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wits_overflow/model/Question.dart';
import 'package:wits_overflow/view/questions_card.dart';

class HistoryView extends StatefulWidget {
  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<Object> _historyList = [];

  void didChangedDependencies() {
    super.didChangeDependencies();
    getUserQuestionsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Questions History"),
      ),
      body: SafeArea(
          child: ListView.builder(
        itemCount: _historyList.length,
        itemBuilder: (context, index) {
          return QuestionsCard(_historyList[index] as Question);
        },
      )),
    );
  }

  Future getUserQuestionsList() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    var data = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("questions")
        .orderBy('created', descending: true)
        .get();

    setState(() {
      _historyList =
          List.from(data.docs.map((doc) => Question.fromSnapshot(doc)));
    });
  }
}
