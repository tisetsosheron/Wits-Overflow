import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wits_overflow/Pages/Comments.dart';
import 'package:wits_overflow/Pages/register.dart';
import 'package:wits_overflow/PostAnswers/post_answers.dart';
import 'package:wits_overflow/components/comment_button.dart';
import 'package:wits_overflow/components/dislike_button.dart';
import 'package:wits_overflow/components/like_button.dart';

class AnswerPost extends StatefulWidget {
  final String answer;
  final String user;
  final String answerId;
  final String question_id;
  final List<String> likes;
  final List<String> dislikes;
  // final Timestamp time;

  const AnswerPost({
    super.key,
    required this.answer,
    required this.answerId,
    required this.user,
    required this.likes,
    required this.dislikes,
    required this.question_id,
  });

  @override
  State<AnswerPost> createState() => _AnswerPostState();
}

class _AnswerPostState extends State<AnswerPost> {
  final CurrentUser = FirebaseAuth.instance.currentUser!;

  bool isLiked = false;
  bool isDisliked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLiked = widget.likes.contains(CurrentUser.email);
    isDisliked = widget.dislikes.contains(CurrentUser.email);
  }

  //toggle Like

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;

      //Access hte document in firebase

      DocumentReference ansRef = FirebaseFirestore.instance
          .collection('mainquestions')
          .doc(widget.question_id)
          .collection('answers')
          .doc(widget.answerId);

      if (isLiked) {
        //if the answer is now liked , add user's Email to the likes field
        ansRef.update({
          'Likes': FieldValue.arrayUnion([CurrentUser.email])
        });
      } else {
        //if the answer is now unliked, remove the user's email from the likes field
        ansRef.update({
          'Likes': FieldValue.arrayRemove([CurrentUser.email])
        });
      }
    });
  }

  void toggleDisLike() {
    setState(() {
      isDisliked = !isDisliked;

      DocumentReference ansRef = FirebaseFirestore.instance
          .collection('mainquestions')
          .doc(widget.question_id)
          .collection('answers')
          .doc(widget.answerId);

      if (isDisliked) {
        //if the answer is now disliked , add user's Email to the dislikes field
        ansRef.update({
          'Dislikes': FieldValue.arrayUnion([CurrentUser.email])
        });
      } else {
        //if the answer is now un-disliked, remove the user's email from the dislikes field
        ansRef.update({
          'Dislikes': FieldValue.arrayRemove([CurrentUser.email])
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.only(top: 25, left: 25, right: 25),
        padding: EdgeInsets.all(25),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user,
                    style: TextStyle(
                        color: const Color.fromARGB(255, 123, 164, 197)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(widget.answer),
                  const SizedBox(
                    height: 10,
                  ),
                  //buttons
                  Row(
                    children: [
                      //Like button
                      LikeButton(isLiked: isLiked, onTap: toggleLike),
                      const SizedBox(
                        width: 5,
                      ),
                      //Like Count
                      Text(widget.likes.length.toString()),
                      const SizedBox(
                        width: 15,
                      ),
                      DislikeButton(
                          isDisliked: isDisliked, onTap: toggleDisLike),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(widget.dislikes.length.toString()),
                      const SizedBox(
                        width: 30,
                      ),
                      //comment button
                      CommentButton(onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => Comments(
                                    Answer_id: widget.answerId,
                                    Question_Id: widget.question_id,
                                  )),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
