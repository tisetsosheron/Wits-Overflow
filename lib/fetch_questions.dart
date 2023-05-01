import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseManager {
  final CollectionReference questions = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('questions');
  Future getUsersList() async {
    List itemsList = [];

    try {
      await questions.get().then((querySnapshot) {
        querySnapshot.docChanges.forEach((element) {
          itemsList.add(element.doc.data());
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
