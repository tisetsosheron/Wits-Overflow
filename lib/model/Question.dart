class Question {
  String? query;         // Represents the question/query text
  String? answer;        // Represents the answer to the question
  String? username;      // Represents the username of the person who asked the question
  DateTime? created;     // Represents the date and time when the question was created

  Question();            // Default constructor for the Question class

  // Converts the Question object to a JSON format
  Map<String, dynamic> toJson() => {
        'query': query,
        'answer': answer,
        'username': username,
        'created': created
      };

  // Constructor to create a Question object from a snapshot 
  Question.fromSnapshot(snapshot)
      : query = snapshot.data()['query'],              // Retrieves the 'query' field value from the snapshot
        answer = snapshot.data()['answer'],            // Retrieves the 'answer' field value from the snapshot
        username = snapshot.data()['username'],        // Retrieves the 'username' field value from the snapshot
        created = snapshot.data()['created'].toDate(); // Retrieves the 'created' field value from the snapshot and converts it to a DateTime object using the toDate() method
}

