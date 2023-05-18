//the answers class represents an answer .It has properties for the answer text (answer) and the timestamp when it was created (created).
// It has methods to convert the class instance to a JSON representation (toJson()) and to create an instance from a Firestore snapshot (answers.fromSnapshot()).

class answers {
  String? answer;
  DateTime? created;

  answers();

  Map<String, dynamic> toJson() => {'answer': answer, 'created': created};
  answers.fromSnapshot(snapshot)
      : answer = snapshot.data()['answer'],
        created = snapshot.data()['created'].toDate();
}
