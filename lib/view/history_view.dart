import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wits_overflow/Pages/MainQuestions.dart';
import 'package:wits_overflow/Widgets/fetch_data.dart';
import 'package:wits_overflow/Widgets/fetch_questions.dart';
import 'package:wits_overflow/model/Question.dart';
import 'package:wits_overflow/view/questions_card.dart';
import 'package:intl/intl.dart';

import '../Widgets/fetch_dates.dart';

class HistoryView extends StatefulWidget {
  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  //Storing the answers gotten from the database as a list
  List<String> docIDs = [];

  Future getDocId() async {
    //Displaying all the questions from the current user only
    await FirebaseFirestore.instance
    //from the users collection
        .collection('users')
    //get the vurrent user ID
        .doc(FirebaseAuth.instance.currentUser?.uid)
    //get the questions collection inside the users collection
    //the question will be specifically those that the current user asked
        .collection('questions')
    //order by newest question first
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
      //The app bar must display what the current page is
      ////must show that this is the questions History
      appBar: AppBar(
        title: Text("Questions History"),
      ),

      //The body of the page
      body: SafeArea(
          child: FutureBuilder(
            future: getDocId(),
            builder: (context, snapshot) {
              //will display the questions as a list view
              return ListView.builder(
                //the number of items must be the number of questions that the current user has asked
                itemCount: docIDs.length,
                itemBuilder: (context, index) {
                  return Card(
                    //each question will be displayed as a list tile
                      child: ListTile(
                        //The title of the listTile will be the actual question asked
                        title: getQuestion(documentId: docIDs[index]),
                        //Trailing will display the date when the question was asked
                        trailing: getDates(documentId: docIDs[index]),
                      ));
                },
              );
            },
          )),
    );
  }
}