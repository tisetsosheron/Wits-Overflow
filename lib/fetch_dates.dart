import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class getDates extends StatelessWidget {
  final String documentId;

  getDates({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference Queries = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('questions');
    return FutureBuilder<DocumentSnapshot>(
        future: Queries.doc(documentId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text(DateFormat('MM/dd/yyyy')
                .format(data['created'].toDate()!)
                .toString());
          }
          return Text('loading...');
        }));
  }
}
