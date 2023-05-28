import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wits_overflow/model/answers.dart';
import 'package:wits_overflow/read%20data/get_main_answers.dart';

import '../Pages/Comments.dart';
import '../components/answer_post.dart';
import '../components/question_post.dart';
import '../read data/get_main_answers_dates.dart';
import 'CommentsId.dart';

class Answers extends StatefulWidget {
  final String questionId;

  Answers({required this.questionId});

  @override
  State<Answers> createState() => _AnswersState();
}

class _AnswersState extends State<Answers> {
  int? selectedAnswerIndex;
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  bool isSearching = false;
  bool isPressed = false;
  bool isPresseddislike = false;
  List<String> docIDs = [];

  answers _answer = answers();

  TextEditingController _answerController = new TextEditingController();

  Future getDocId() async {
    docIDs.clear();
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

  //get username of the person answering
  String getUserName() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        //gets document for current user
        if (documentSnapshot.get('username') != null) {
          //gets current user's username
          return documentSnapshot.get('username').toString().trim();
        }
      } else {
        print('Document does not exist on the database');
      }
    });
    return "Anonymous";
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
        child: Container(
          color: Color.fromARGB(255, 185, 184, 184),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('mainquestions')
                          .doc(widget.questionId)
                          .collection('answers')
                          .orderBy("created", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final mainAnswer = snapshot.data!.docs[index];
                              return AnswerPost(
                                answer: mainAnswer['answer'],
                                user: mainAnswer['username'],
                                answerId: mainAnswer.id,
                                likes: List<String>.from(
                                    mainAnswer['Likes'] ?? []),
                                dislikes: List<String>.from(
                                    mainAnswer['Dislikes'] ?? []),
                                question_id: widget.questionId,
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text("Error:${snapshot.error}"));
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      })),
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
      ),
    );
  }

  void PostAnswer() async {
    _answer.answer = _answerController.text;
    _answer.username = getUserName();
    _answer.created = DateTime.now();
    _answer.Likes = [];
    _answer.Dislikes = [];
    if (_answerController.text.isNotEmpty) {
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
}
