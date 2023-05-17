import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wits_overflow/Widgets/fetch_data.dart';

import '../Pages/ProfileEdit.dart';
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
  bool isSearching = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: !isSearching
            ? Text("Question History",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
            : TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  hintText: "search question by keyword",
                ),
              ),
        actions: [
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  color: Colors.black,
                  onPressed: () {
                    setState(() {
                      this.isSearching = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.black,
                  onPressed: () {
                    setState(() {
                      this.isSearching = true;
                    });
                  },
                  tooltip: 'search answer',
                ),
          IconButton(
            icon: Icon(Icons.home),
            color: Colors.blue,
            onPressed: null,
            tooltip: 'go to home',
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProfileEdit(),
                ));
              },
              icon: Icon(Icons.person),
              tooltip: 'view profile',
              color: Colors.deepOrange),
        ],
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
                leading: InkWell(
                  onTap: () async {
                    Tooltip:
                    'delete question';
                    deleteQuestion('N8vaMTayoxkgA1RYvHl3');
                    // deleteQuestion('xZEGitW2H8QcoMMCamm8');
                  },
                  child: IconButton(
                    //
                    icon: Icon(Icons.delete),
                    color: Colors.blue,
                    onPressed: () {
                      deleteQuestion('N8vaMTayoxkgA1RYvHl3');
                      // deleteQuestion('xZEGitW2H8QcoMMCamm8');
                    },
                    tooltip: 'delete question',
                  ),
                ),
                title: getQuestion(documentId: docIDs[index]),
                trailing: getDates(documentId: docIDs[index]),
              ));
            },
          );
        },
      )),
    );
  }

  void deleteQuestion(id) {
    FirebaseFirestore.instance.collection('mainquestions').doc(id).delete();

    Fluttertoast.showToast(msg: "question deleted");
  }
}
