import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wits_overflow/ProfileEdit.dart';
import 'package:wits_overflow/model/Question.dart';
import 'package:wits_overflow/view/history_view.dart';

class CounterScreenState extends StatefulWidget {
  const CounterScreenState({super.key});

  @override
  CounterScreen createState() => CounterScreen();
}

class CounterScreen extends State<CounterScreenState> {
  TextEditingController _questionController = TextEditingController();
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: !isSearching
            ? Text("Questions",
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
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) => Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Card(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                /* Container(
                                  width: 55.0,
                                  height: 90,
                                  color: Colors.white,
                                  child: /*IconButton(
                                    onPressed: null,
                                    icon: const Icon(
                                      Icons.account_box,
                                      size: 50.0,
                                    ),
                                    alignment: Alignment.topLeft,
                                    tooltip: 'visit profile',
                                  ),*/
                                ),*/
                                SizedBox(
                                  width: 3.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 20,
                                      height: 10,
                                    ),
                                    //this is the text that will show the username of the person that has answered a question
                                    Text(
                                      '',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    //a sizedbox to create space between profile name and answer
                                    SizedBox(
                                      width: 20,
                                      height: 10.0,
                                    ),
                                    //this will show the answer to the particular person has given
                                    Text('',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 15))
                                  ],
                                )
                              ],
                            ),
                            //Creating a column view,  where the Icon buttons will we
                            //the like and dislike buttons will be shown here
                            Column(
                              children: <Widget>[
                                /*  IconButton(
                                  icon: const Icon(
                                    Icons.thumb_up,
                                    size: 20.0,
                                  ),
                                  onPressed: () {
                                    incrementCounter();
                                    isPressed = true;
                                  },
                                  color: (isPressed)
                                      ? Colors.deepOrange
                                      : Colors.grey,
                                  tooltip: 'like this answer',
                                ),*/
                                /*IconButton(
                                  icon: const Icon(
                                    Icons.thumb_down,
                                    size: 20.0,
                                  ),
                                  color: (isPresseddislike)
                                      ? Colors.blueGrey
                                      : Colors.grey,
                                  tooltip: 'dislike this answer',
                                  onPressed: () {
                                    incrementCounterr();
                                    isPresseddislike = true;
                                  },
                                ),*/
                              ],
                            ),

                            //creating another column view
                            //for the text that will show the number of likes and the number of dislikes
                            /*Column(
                              children: <Widget>[
                                SizedBox(
                                  width: 20.0,
                                  height: 5.0,
                                ),
                                Text(
                                  "$counter likes",
                                ),
                                SizedBox(
                                  width: 20.0,
                                  height: 25.0,
                                ),
                                Text(
                                  "$counterr dislikes",
                                ),
                              ],
                            ),*/
                          ],
                        ))),
              ),
            ),
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
    _questionController.text = "";
  }

  void History() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => HistoryView(),
    ));
  }
}
