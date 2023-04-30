import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wits_overflow/model/Question.dart';

class QuestionsCard extends StatelessWidget {
  final Question _question;
  QuestionsCard(this._question);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text("${_question.query}?"),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                      "${DateFormat('MM/dd/yyyy').format(_question.created!).toString()}"),
                  Spacer(),
                ],
              )
            ],
          )),
    ));
  }
}
