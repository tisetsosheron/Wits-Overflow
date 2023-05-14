import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wits_overflow/PostAnswers/post_answers.dart';
import 'package:wits_overflow/homepage.dart';
import 'package:wits_overflow/read%20data/get_main_dates.dart';
import 'package:wits_overflow/read%20data/get_main_questions.dart';

import 'ProfileEdit.dart';
import 'fetch_questions.dart';
import 'model/Question.dart';
import 'view/history_view.dart';

class CounterScreenState extends StatefulWidget {
  const CounterScreenState({super.key});

  @override
  CounterScreen createState() => CounterScreen();
}

class CounterScreen extends State<CounterScreenState> {
  TextEditingController _questionController = TextEditingController();
  //document IDs
  List<String> docIds = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection("mainquestions")
        .orderBy('created', descending: true)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIds.add(document.reference.id);
            }));
  }

  Question _question = Question();
  @override
  bool isSearching = false;
  bool isPressed = false;
  bool isPresseddislike = false;

  //im going to use this for the button to increment the number of upvotes and downvotes
  //initializing counter and creating a counter method
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  int counterr = 0;

  void incrementCounterr() {
    setState(() {
      counterr++;
    });
  }

  List usersQuestionsList = [];

  FetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getUsersList();

    if (resultant == null) {
      print('Unable to print');
    } else {
      setState(() {
        usersQuestionsList = resultant;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: !isSearching
            ? Text("Add Question",
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
          IconButton(
              onPressed: History,
              icon: Icon(Icons.history),
              tooltip: 'Ask a Question',
              color: Colors.black)
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
                future: getDocId(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: docIds.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: ListTile(
                          title: getMainQuestion(documentId: docIds[index]),
                          subtitle: getMainDates(documentId: docIds[index]),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Answers(),
                            ));
                          },
                        ));
                      });
                }),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _questionController,
                  decoration: InputDecoration(hintText: "Ask a question"),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                tooltip: 'post',
                onPressed: () {
                  Postquestion();
                  // DatabaseManager().getUsersList();
                },
              )
            ],
          )
        ],
      ),
    );
  }

  void Postquestion() async {
    _question.query = _questionController.text;
    _question.answer = "No answer yet";
    _question.created = DateTime.now();

    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('questions')
        .add(_question.toJson());
    await FirebaseFirestore.instance
        .collection("mainquestions")
        .add(_question.toJson());
    _questionController.text = '';
    Fluttertoast.showToast(
        msg: "Question Posted.Click on the history icon to view",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        fontSize: 20);
  }

  void History() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => HistoryView(),
    ));
  }

  String returnText(String question) {
    if (question == null) {
      return '';
    } else {
      return question;
    }
  }
}
