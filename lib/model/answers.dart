class Answers {
  String? answer;          // Represents the answer text
  DateTime? created;       // Represents the date and time when the answer was created
  String? username;        // Represents the username of the person who provided the answer
  List<String>? likes;     // Represents the list of usernames who liked the answer
  List<String>? dislikes;  // Represents the list of usernames who disliked the answer

  Answers();               // Default constructor for the Answers class

  // Converts the Answers object to a JSON format
  Map<String, dynamic> toJson() => {
        'answer': answer,
        'username': username,
        'created': created,
        'likes': likes,
        'dislikes': dislikes
      };

  // Constructor to create an Answers object from a snapshot 
  Answers.fromSnapshot(snapshot)
      : answer = snapshot.data()['answer'],                // Retrieves the 'answer' field value from the snapshot
        username = snapshot.data()['username'],            // Retrieves the 'username' field value from the snapshot
        created = snapshot.data()['created'].toDate(),     // Retrieves the 'created' field value from the snapshot and converts it to a DateTime object using the toDate() method
        likes = snapshot.data()['likes'],                  // Retrieves the 'likes' field value from the snapshot
        dislikes = snapshot.data()['dislikes'];            // Retrieves the 'dislikes' field value from the snapshot
}
