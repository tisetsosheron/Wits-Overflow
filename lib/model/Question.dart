class Question {
  String? query;
  String? answer;
  String? username;
  DateTime? created;

  Question();

  Map<String, dynamic> toJson() => {
        'query': query,
        'answer': answer,
        'username': username,
        'created': created
      };

  Question.fromSnapshot(snapshot)
      : query = snapshot.data()['query'],
        answer = snapshot.data()['answer'],
        username = snapshot.data()['username'],
        created = snapshot.data()['created'].toDate();
}
