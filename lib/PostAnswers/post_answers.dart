import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wits_overflow/model/answers.dart';
import 'package:wits_overflow/read%20data/get_main_answers.dart';

import '../Pages/Comments.dart';
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

  //im going to use this for the button to increment the number of upvotes and downvotes
  //initializing counter and creating a counter method
  int counter = 0;

  void incrementCounter() async {
    if (selectedAnswerIndex != null) {
      String docId = docIDs[selectedAnswerIndex!];

      await FirebaseFirestore.instance
          .collection('mainquestions')
          .doc(widget.questionId)
          .collection('answers')
          .doc(docId)
          .update({'like': FieldValue.increment(1)});

      setState(() {
        counter++;
      });
    }
  }

  //int counterr = 0;

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
            Expanded(
              child: FutureBuilder(
                  future: getDocId(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                        itemCount: docIDs.length,
                        itemBuilder: (context, index) {
                          return Card(
                              child: ListTile(
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
                                      icon: Icon(
                                        FontAwesomeIcons.solidThumbsUp,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          selectedAnswerIndex = index;
                                        });
                                        incrementCounter();
                                        isPressed = true;
                                      },
                                      color: (isPressed)
                                          ? Colors.deepOrange
                                          : Colors.grey,
                                      tooltip: 'like this answer',
                                    ),
                                    Text("$counter"),
                                    IconButton(
                                      icon: Icon(
                                        FontAwesomeIcons.solidThumbsDown,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        //incrementCounterr();
                                        isPresseddislike = true;
                                      },
                                    ),
                                    //Text("$counterr"),
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
                            trailing: getMainAnswersDates(
                              documentId: docIDs[index],
                              questionId: widget.questionId,
                            ),
                          ));
                        });
                  }),
            ),
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
