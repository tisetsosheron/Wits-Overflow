import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wits_overflow/Pages/Comments.dart';
import 'package:wits_overflow/Pages/register.dart';
import 'package:wits_overflow/PostAnswers/post_answers.dart';
import 'package:wits_overflow/components/comment_button.dart';
import 'package:wits_overflow/components/dislike_button.dart';
import 'package:wits_overflow/components/like_button.dart';

class CommentPost extends StatefulWidget {
  final String comment;
  final String user;
  final String Question_id;
  final String answer_id;
  final List<String> likes;
  final List<String> dislikes;
  final String comment_id;
  // final Timestamp time;

  const CommentPost({
    super.key,
    required this.comment,
    required this.user,
    required this.likes,
    required this.dislikes,
    required this.answer_id,
    required this.Question_id,
    required this.comment_id,
  });

  @override
  State<CommentPost> createState() => _CommentPostState();
}

class _CommentPostState extends State<CommentPost> {
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

      DocumentReference comRef = FirebaseFirestore.instance
          .collection('mainquestions')
          .doc(widget.Question_id)
          .collection('answers')
          .doc(widget.answer_id)
          .collection('comments')
          .doc(widget.comment_id);

      if (isLiked) {
        //if the answer is now liked , add user's Email to the likes field
        comRef.update({
          'Likes': FieldValue.arrayUnion([CurrentUser.email])
        });
      } else {
        //if the answer is now unliked, remove the user's email from the likes field
        comRef.update({
          'Likes': FieldValue.arrayRemove([CurrentUser.email])
        });
      }
    });
  }

  void toggleDisLike() {
    setState(() {
      isDisliked = !isDisliked;

      DocumentReference comRef = FirebaseFirestore.instance
          .collection('mainquestions')
          .doc(widget.Question_id)
          .collection('answers')
          .doc(widget.answer_id)
          .collection('comments')
          .doc(widget.comment_id);

      if (isDisliked) {
        //if the answer is now disliked , add user's Email to the dislikes field
        comRef.update({
          'Dislikes': FieldValue.arrayUnion([CurrentUser.email])
        });
      } else {
        //if the answer is now un-disliked, remove the user's email from the dislikes field
        comRef.update({
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
                  Text(widget.comment),
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
