class comments {
  String? comment;
  DateTime? created;
  String? username;
  List<String>? Likes;
  List<String>? Dislikes;

  comments();

  Map<String, dynamic> toJson() => {
        'comment': comment,
        'username': username,
        'created': created,
        'Likes': Likes,
        'Dislikes': Dislikes
      };
  comments.fromSnapshot(snapshot)
      : comment = snapshot.data()['comment'],
        username = snapshot.data()['username'],
        created = snapshot.data()['created'].toDate(),
        Likes = snapshot.data()['Likes'],
        Dislikes = snapshot.data()['Dislikes'];
}
