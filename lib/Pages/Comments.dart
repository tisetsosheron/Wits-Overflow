import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wits_overflow/PostAnswers/QuestionId.dart';
import 'package:wits_overflow/Pages/homepage.dart';
import 'package:wits_overflow/model/answers.dart';
import 'package:wits_overflow/read%20data/get_main_answers.dart';
import 'package:wits_overflow/read%20data/get_main_comments_dates.dart';
import 'package:wits_overflow/read%20data/get_main_dates.dart';
import 'package:wits_overflow/read%20data/get_main_questions.dart';

import '../model/comments.dart';
import '../read data/get_main_comments.dart';

class Comments extends StatefulWidget {
  final String commentsId;

  Comments({required this.commentsId});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  List<String> docIDs = [];

  comments _comment = comments();

  TextEditingController __commentController = new TextEditingController();

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('Comments')
        .doc(widget.commentsId)
        .collection('comments')
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
        title: Text("Add Comment",
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
                            title: getMainComments(
                              documentId: docIDs[index],
                              commentId: widget.commentsId,
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
                                  ],
                                )
                              ],
                            ),
                            trailing: getMainCommentsDates(
                              documentId: docIDs[index],
                              commentsId: widget.commentsId,
                            ),
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
    );
  }

  void PostComment() async {
    _comment.comment = __commentController.text;

    _comment.created = DateTime.now();

    await FirebaseFirestore.instance
        .collection("Comments")
        .doc(widget.commentsId)
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
