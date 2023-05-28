class answers {
  String? answer;
  DateTime? created;
  String? username;
  List<String>? Likes;
  List<String>? Dislikes;

  answers();

  Map<String, dynamic> toJson() => {
        'answer': answer,
        'username': username,
        'created': created,
        'Likes': Likes,
        'Dislikes': Dislikes
      };
  answers.fromSnapshot(snapshot)
      : answer = snapshot.data()['answer'],
        username = snapshot.data()['username'],
        created = snapshot.data()['created'].toDate(),
        Likes = snapshot.data()['Likes'],
        Dislikes = snapshot.data()['Dislikes'];
}
