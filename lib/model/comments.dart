class Comments {
  String? comment;         // Represents the comment text
  DateTime? created;       // Represents the date and time when the comment was created
  String? username;        // Represents the username of the person who made the comment
  List<String>? likes;     // Represents the list of usernames who liked the comment
  List<String>? dislikes;  // Represents the list of usernames who disliked the comment

  Comments();              // Default constructor for the Comments class

  // Converts the Comments object to a JSON format
  Map<String, dynamic> toJson() => {
        'comment': comment,
        'username': username,
        'created': created,
        'likes': likes,
        'dislikes': dislikes
      };

  // Constructor to create a Comments object from a snapshot 
  Comments.fromSnapshot(snapshot)
      : comment = snapshot.data()['comment'],                // Retrieves the 'comment' field value from the snapshot
        username = snapshot.data()['username'],              // Retrieves the 'username' field value from the snapshot
        created = snapshot.data()['created'].toDate(),       // Retrieves the 'created' field value from the snapshot and converts it to a DateTime object using the toDate() method
        likes = snapshot.data()['likes'],                    // Retrieves the 'likes' field value from the snapshot
        dislikes = snapshot.data()['dislikes'];              // Retrieves the 'dislikes' field value from the snapshot
}
