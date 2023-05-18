// import 'package:test/test.dart';
// import 'package:wits_overflow/PostAnswers/post_answers.dart';
// import 'package:wits_overflow/model/answers.dart';

// void main() {
//   test('Answers object should be correctly created', () {
//     // Create an instance of the Answers class
//     final answers = Answers();

//     // Set the properties of the Answers object
//     answers.answer = 'The meaning of life is 42';
//     answers.created = DateTime.now();

//     // Assert that the properties are set correctly
//     expect(answers.answer, equals('The meaning of life is 42'));
//     expect(answers.created, isNotNull);
//   });

//   test('Answers object should be correctly created from snapshot', () {
//     // Create a sample snapshot with data
//     final snapshot = {
//       'answer': 'The meaning of life is 42',
//       'created': DateTime.now().toIso8601String(),
//     };

//     // Create an instance of the Answers class from the snapshot
//     final answers = Answers.fromSnapshot(snapshot);

//     // Assert that the properties are set correctly
//     expect(answers.answer, equals('The meaning of life is 42'));
//     expect(answers.created, isNotNull);
//   });
// }
