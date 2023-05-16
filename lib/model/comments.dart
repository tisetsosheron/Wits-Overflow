class comments {
  String? comment;
  DateTime? created;

  comments();

  Map<String, dynamic> toJson() => {'comment': comment, 'created': created};
  comments.fromSnapshot(snapshot)
      : comment = snapshot.data()['comment'],
        created = snapshot.data()['created'].toDate();
}
