import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wits_overflow/Pages/register.dart';
import 'package:wits_overflow/PostAnswers/post_answers.dart';

class QuestionPost extends StatelessWidget {
  final String question;
  final String user;
  final String questionId;
  // final Timestamp time;

  const QuestionPost(
      {super.key,
      required this.question,
      required this.user,
      required this.questionId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Answers(questionId: questionId),
        ));
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
                  Text(
                    user,
                    style: TextStyle(
                        color: const Color.fromARGB(255, 123, 164, 197)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(question),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
