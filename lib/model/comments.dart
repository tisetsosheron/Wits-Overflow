////the comments class represents a comment .It has properties for the comment text (comment) and the timestamp when it was created (created).
// // It has methods to convert the class instance to a JSON representation (toJson()) and to create an instance from a Firestore snapshot (comments.fromSnapshot()).

class comments {
  String? comment;
  DateTime? created;

  comments();

  Map<String, dynamic> toJson() => {'comment': comment, 'created': created};
  comments.fromSnapshot(snapshot)
      : comment = snapshot.data()['comment'],
        created = snapshot.data()['created'].toDate();
}
