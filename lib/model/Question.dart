// this class represents a question. It has properties for the question text (query), the answer text (answer), and the timestamp when it was created (created).
// It provides methods to convert the class instance to a JSON representation (toJson()) and to create an instance from a Firestore snapshot (Question.fromSnapshot()).


class Question {
  String? query;
  String? answer;
  DateTime? created;

  Question();

  Map<String, dynamic> toJson() =>
      {'query': query, 'answer': answer, 'created': created};

  Question.fromSnapshot(snapshot)
      : query = snapshot.data()['query'],
        answer = snapshot.data()['answer'],
        created = snapshot.data()['created'].toDate();
}
