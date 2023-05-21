import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wits_overflow/PostAnswers/QuestionId.dart';
import 'package:wits_overflow/Pages/homepage.dart';
import 'package:wits_overflow/model/answers.dart';
import 'package:wits_overflow/read%20data/get_main_answers.dart';
import 'package:wits_overflow/read%20data/get_main_dates.dart';
import 'package:wits_overflow/read%20data/get_main_questions.dart';

import '../Pages/Comments.dart';
import '../read data/get_main_answers_dates.dart';
import '../read data/get_main_comments.dart';
import 'CommentsId.dart';

class Answers extends StatefulWidget {
  final String questionId;

  Answers({required this.questionId});

  @override
  State<Answers> createState() => _AnswersState();
}

class _AnswersState extends State<Answers> {
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  List<String> docIDs = [];

  answers _answer = answers();

  TextEditingController _answerController = new TextEditingController();




  //The method getDocId() is an asynchronous function that retrieves the document IDs from the Firestore collection.
  //this method retrieves the document IDs of the answers subcollection within the specified main question document in Firestore.
  // It sorts the answers based on the "created" field in descending order and stores the document IDs in a list called docIDs.
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('mainquestions')
        .doc(widget.questionId)
        .collection('answers')
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
        backgroundColor: Colors.white70,
        title: Text("Add Answer",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[

            //This is basically the interface of the "post answers" page will all the buttons that the user will use
            //the list view if for displaying the answers retrieved from the database
            Expanded(
              child: FutureBuilder(
                  future: getDocId(),
                  builder: (context, snapshot) {

                    //This basically create the list view for displaying the answers on the database
                    return ListView.builder(
                        itemCount: docIDs.length,
                        itemBuilder: (context, index) {
                          return Card(
                              child: ListTile(

                                //This code basically display tha answer posted by the user on the list tile
                            title: getMainAnswers(
                              documentId: docIDs[index],
                              questionId: widget.questionId,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        FontAwesomeIcons.solidThumbsUp,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ),
                                    Text("10"),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        FontAwesomeIcons.solidThumbsDown,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ),
                                    Text("5         "),
                                    Center(
                                      child: Column(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                print(CommentsId()
                                                    .setId(docIDs[index]));
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      Comments(
                                                          commentsId:
                                                              CommentsId()
                                                                  .setId(docIDs[
                                                                      index])),
                                                ));
                                              },
                                              icon: Icon(Icons
                                                  .messenger_outline_sharp))
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),

                            //the getMainAnswersDate is a method that get the date that the answer was added on
                                // this code is for displaying the date of an answer of the bottom right side of the list tile
                            trailing: getMainAnswersDates(
                              documentId: docIDs[index],
                              questionId: widget.questionId,
                            ),
                          ));
                        });
                  }),
            ),

            //This is the where the user type their answer and post it
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _answerController,
                    decoration: InputDecoration(hintText: "Add an answer"),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  tooltip: 'post',
                  onPressed: () {
                    PostAnswer();

                    // DatabaseManager().getUsersList();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  //This method posts the answer and the date the answer was addedon firebase database under the "answers" collection
  //The answer is added for the corresponding question

  void PostAnswer() async {
    _answer.answer = _answerController.text;

    _answer.created = DateTime.now();

    await FirebaseFirestore.instance
        .collection("mainquestions")
        .doc(widget.questionId)
        .collection('answers')
        .add(_answer.toJson());

    _answerController.text = '';
    Fluttertoast.showToast(
        msg: "Answer Posted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        fontSize: 20);
  }
}
