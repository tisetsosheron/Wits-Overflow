// class Question {
//   final String id;
//   final String title;
//   final String description;
//   final String userId;
//
//   Question({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.userId,
//   });
//
//   factory Question.fromJson(Map<String, dynamic>? json) {
//     if (json == null) {
//       throw ArgumentError.notNull('json');
//     }
//
//     return Question(
//       id: json['id'],
//       title: json['title'],
//       description: json['description'],
//       userId: json['userId'],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'title': title,
//         'description': description,
//         'userId': userId,
//       };
// }
