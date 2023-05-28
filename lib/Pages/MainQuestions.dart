import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:wits_overflow/PostAnswers/QuestionId.dart';
import 'package:wits_overflow/PostAnswers/post_answers.dart';
import 'package:wits_overflow/Pages/homepage.dart';
import 'package:wits_overflow/read%20data/get_main_dates.dart';
import 'package:wits_overflow/read%20data/get_main_questions.dart';

import '../components/question_post.dart';
import 'ProfileEdit.dart';
import '../Widgets/fetch_questions.dart';
import '../model/Question.dart';
import '../view/history_view.dart';

class CounterScreenState extends StatefulWidget {
  final String currentUser;

  const CounterScreenState({super.key, required this.currentUser});

  @override
  CounterScreen createState() => CounterScreen();
}

class CounterScreen extends State<CounterScreenState> {
  TextEditingController _questionController = TextEditingController();
  // final user = FirebaseAuth.instance.currentUser!;
  //document IDs
  List<String> docIds = [];

  Future getDocId() async {
    docIds.clear();
    await FirebaseFirestore.instance
        .collection("mainquestions")
        .orderBy('created', descending: true)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIds.add(document.reference.id);
            }));
  }

  getUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((ds) {
        CounterScreenState(currentUser: ds['username']);
      }).catchError((e) {
        print(e);
      });
    }
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
      body: Container(
        color: Color.fromARGB(255, 185, 184, 184),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('mainquestions')
                        .orderBy("created", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final mainQuestion = snapshot.data!.docs[index];
                            return QuestionPost(
                              question: mainQuestion['query'],
                              user: mainQuestion['username'],
                              questionId: mainQuestion.id,
                              date: DateFormat('MM/dd/yyyy')
                                  .format(mainQuestion['created'].toDate()!)
                                  .toString(),
                              currentUser: widget.currentUser,
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
                    controller: _questionController,
                    decoration: InputDecoration(hintText: "Ask a question"),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  tooltip: 'post',
                  onPressed: () {
                    getUserName();
                    Postquestion();
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

  void Postquestion() async {
    _question.query = _questionController.text;
    _question.username = widget.currentUser;
    _question.created = DateTime.now();
    if (_questionController.text.isNotEmpty) {
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
