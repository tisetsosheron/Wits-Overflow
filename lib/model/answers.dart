class answers {
  String? answer;
  DateTime? created;

  answers();

  Map<String, dynamic> toJson() => {'answer': answer, 'created': created};
  answers.fromSnapshot(snapshot)
      : answer = snapshot.data()['answer'],
        created = snapshot.data()['created'].toDate();
}
