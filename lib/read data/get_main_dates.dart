import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class getMainDates extends StatelessWidget {
  final String documentId;

  getMainDates({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference mainquestions =
        FirebaseFirestore.instance.collection('mainquestions');

    return FutureBuilder<DocumentSnapshot>(
        future: mainquestions.doc(documentId).get(),
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
