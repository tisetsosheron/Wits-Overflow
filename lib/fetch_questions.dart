// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import 'data_page.dart';
//
// class AddQuestionWidget extends StatefulWidget {
//   @override
//   _AddQuestionWidgetState createState() => _AddQuestionWidgetState();
// }
//
// class _AddQuestionWidgetState extends State<AddQuestionWidget> {
//   final _formKey = GlobalKey<FormState>();
//   late String _title;
//   late String _description;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Question'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             TextFormField(
//               decoration: const InputDecoration(
//                 hintText: 'Enter the title',
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter the title';
//                 }
//                 return null;
//               },
//               onChanged: (value) {
//                 _title = value;
//               },
//             ),
//             TextFormField(
//               decoration: const InputDecoration(
//                 hintText: 'Enter the description',
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter the description';
//                 }
//                 return null;
//               },
//               onChanged: (value) {
//                 _description = value;
//               },
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 16.0),
//               child: ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     final user = FirebaseAuth.instance.currentUser;
//                     final question = Question(
//                       id: '',
//                       title: _title,
//                       description: _description,
//                       userId: user!.uid,
//                     );
//
//                     await FirebaseFirestore.instance
//                         .collection('questions')
//                         .add(question.toJson());
//
//                     Navigator.pop(context);
//                   }
//                   ;
//                 },
//                 child: const Text('Submit'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
