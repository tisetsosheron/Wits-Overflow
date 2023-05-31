import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wits_overflow/Pages/register.dart';
import 'package:wits_overflow/PostAnswers/post_answers.dart';

class QuestionPost extends StatelessWidget {
  final String question;       // Represents the question text
  final String user;          // Represents the username of the user who asked the question
  final String currentUser;   // Represents the username of the current user
  final String questionId;    // Represents the ID of the question
  final String date;         // Represents the date of the question post

  const QuestionPost({
    super.key,
    required this.question,
    required this.user,
    required this.questionId,
    required this.date,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (user != currentUser) {   // Check if the current user is not the same as the user who asked the question
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Answers(
              questionId: questionId,    // Passes the question ID to the Answers page
              username: currentUser,    // Passes the current user's username to the Answers page
            ),
          ));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.only(top: 25, left: 25, right: 25),
        padding: EdgeInsets.all(25),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[400],
              ),
              padding: EdgeInsets.all(10),
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Username of the user who asked the question
                  Text(
                    user,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 123, 164, 197)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // The question itself
                  Text(
                    question,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Date of the question post
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey),
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
