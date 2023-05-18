import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wits_overflow/PostAnswers/QuestionId.dart';
import 'package:wits_overflow/PostAnswers/post_answers.dart';
import 'package:wits_overflow/Pages/homepage.dart';
import 'package:wits_overflow/read%20data/get_main_dates.dart';
import 'package:wits_overflow/read%20data/get_main_questions.dart';

import 'ProfileEdit.dart';
import '../Widgets/fetch_questions.dart';
import '../model/Question.dart';
import '../view/history_view.dart';

class CounterScreenState extends StatefulWidget {
  const CounterScreenState({super.key});

  @override
  CounterScreen createState() => CounterScreen();
}

class CounterScreen extends State<CounterScreenState> {
  TextEditingController _questionController = TextEditingController();
  //document IDs
  List<String> docIds = [];


//this method retrieves the document IDs from the "mainquestions" collection in Firestore.
// It sorts the documents based on the "created" field in descending order and stores the document IDs in a list called docIds.
// Additionally, it prints the references of each document during the retrieval process.
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


//this line of code initializes the usersQuestions list
  List usersQuestionsList = [];


//The method FetchDatabaseList() is an asynchronous function that retrieves a list of users' questions from a database
  // this method fetches a list of users' questions from a database using an asynchronous operation.
  // If the retrieval is successful, it updates the state variable usersQuestionsList and triggers a UI update.
  // If the retrieval is unsuccessful or returns null, it prints an error message.

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


      //This is the interface of the "Ask questions screen" will all the buttons, textfields and icons needed
      //its the visuals
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: !isSearching
            ? const Text("Add Question",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
            : const TextField(
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
                            print(QuestionId().setId(docIds[index]));

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Answers(
                                  questionId:
                                      QuestionId().setId(docIds[index])),
                            ));
                          },
                        ));
                      });
                }),
          ),


          //This is the where the user type their question and post it
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
//The Postquestion() method is a function that posts a question to two different collections in Firestore.
  //this method takes the question entered by the user,
  //adds the question data to both the user-specific "questions" collection and the general "mainquestions" collection in Firestore.
  // It also clears the input field and displays a toast message to indicate that the question has been posted.
  void Postquestion() async {
    _question.query = _questionController.text;

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


// this method is responsible for navigating to the HistoryView screen .
// It uses the Navigator class to handle the navigation operation and displays the specified widget on the new screen.
  void History() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => HistoryView(),
    ));
  }

  //this method checks if the question string is null and returns either an empty string or the original question string.
  // It provides a way to handle null values and ensure that the method always returns a valid string.

  String returnText(String question) {
    if (question == null) {
      return '';
    } else {
      return question;
    }
  }
}
