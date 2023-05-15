import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wits_overflow/PostAnswers/QuestionId.dart';
import 'package:wits_overflow/homepage.dart';
import 'package:wits_overflow/model/answers.dart';
import 'package:wits_overflow/read%20data/get_main_answers.dart';
import 'package:wits_overflow/read%20data/get_main_dates.dart';
import 'package:wits_overflow/read%20data/get_main_questions.dart';

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

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('mainquestions')
        .doc(widget.questionId)
        .collection('answers')
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          Text("5"),
                                        ],
                                      )
                                    ],
                                  )
                                  // subtitle: getMainDates(documentId: docIds[index]),
                                  // onTap: () {
                                  //   Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) => Dashboard(),
                                  //   ));
                                  // },
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
