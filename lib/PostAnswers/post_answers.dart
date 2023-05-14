import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wits_overflow/homepage.dart';
import 'package:wits_overflow/read%20data/get_main_dates.dart';
import 'package:wits_overflow/read%20data/get_main_questions.dart';

class Answers extends StatefulWidget {
  const Answers({super.key});

  @override
  State<Answers> createState() => _AnswersState();
}

class _AnswersState extends State<Answers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text("Add Answer",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: FutureBuilder(builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Card(
                        child: ListTile(
                      title: Text("Answers"),
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
                  // controller: _questionController,
                  decoration: InputDecoration(hintText: "Add an answer"),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                tooltip: 'post',
                onPressed: () {
                  // Postquestion();
                  // DatabaseManager().getUsersList();
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
