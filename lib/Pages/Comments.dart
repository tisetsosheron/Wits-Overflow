import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wits_overflow/PostAnswers/QuestionId.dart';
import 'package:wits_overflow/Pages/homepage.dart';
import 'package:wits_overflow/components/comment_post.dart';
import 'package:wits_overflow/model/answers.dart';
import 'package:wits_overflow/read%20data/get_main_answers.dart';
import 'package:wits_overflow/read%20data/get_main_comments_dates.dart';
import 'package:wits_overflow/read%20data/get_main_dates.dart';
import 'package:wits_overflow/read%20data/get_main_questions.dart';

import '../model/comments.dart';
import '../read data/get_main_comments.dart';

class Comments extends StatefulWidget {
  final String Question_Id;
  final String Answer_id;

  Comments({required this.Question_Id, required this.Answer_id});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  List<String> docIDs = [];

  comments _comment = comments();

  TextEditingController __commentController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text("Add Comment",
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
                          .doc(widget.Question_Id)
                          .collection('answers')
                          .doc(widget.Answer_id)
                          .collection("comments")
                          .orderBy("created", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final mainComment = snapshot.data!.docs[index];
                                return CommentPost(
                                    comment: mainComment['comment'],
                                    user: mainComment['username'],
                                    likes: List<String>.from(
                                        mainComment['Likes'] ?? []),
                                    dislikes: List<String>.from(
                                        mainComment['Dislikes'] ?? []),
                                    answer_id: widget.Answer_id,
                                    Question_id: widget.Question_Id,
                                    comment_id: mainComment.id);
                              });
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
                      controller: __commentController,
                      decoration: InputDecoration(hintText: "Add an answer"),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    tooltip: 'post',
                    onPressed: () {
                      PostComment();

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

  void PostComment() async {
    _comment.comment = __commentController.text;
    _comment.Likes = [];
    _comment.Dislikes = [];
    _comment.created = DateTime.now();
    _comment.username = getUserName();
    if (__commentController.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection("mainquestions")
          .doc(widget.Question_Id)
          .collection('answers')
          .doc(widget.Answer_id)
          .collection('comments')
          .add(_comment.toJson());

      __commentController.text = '';
      Fluttertoast.showToast(
          msg: "Comment Posted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 20);
    }
  }
}
