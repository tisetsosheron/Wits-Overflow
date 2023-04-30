// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'data_page.dart';
//
// class QuestionListWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('questions').snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const CircularProgressIndicator();
//         }
//         //Map<String, dynamic> map = snap.snapshot.value as Map<String, dynamic>;
//         //final users.map((user) => Text(user['username'])).toList(),
//         final questions = snapshot.data!.docs
//             .map((doc) => Question.fromJson(doc.data() as Map<String, dynamic>?))
//             .toList();
//
//         return ListView.builder(
//           itemCount: questions.length,
//           itemBuilder: (context, index) {
//             final question = questions[index];
//             return ListTile(
//               title: Text(question.title),
//               subtitle: Text(question.description),
//             );
//           },
//         );
//       },
//     );
//   }
// }
