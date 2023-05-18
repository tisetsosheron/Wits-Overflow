// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
// import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
// import 'package:wits_overflow/read%20data/get_main_questions.dart';


// void main() {
//   MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
//   MockFirestoreInstance mockFirestoreInstance = MockFirestoreInstance();

//   // Create a test widget with the getMainQuestion widget
//   Widget _buildTestWidget(String documentId) {
//     return MaterialApp(
//       home: Scaffold(
//         body: getMainQuestion(documentId: documentId),
//       ),
//     );
//   }

//   testWidgets('getMainQuestion displays loading text while fetching data',
//       (WidgetTester tester) async {
//     // Build the test widget
//     await tester.pumpWidget(_buildTestWidget('example_document_id'));

//     // Verify that the loading text is displayed initially
//     expect(find.text('loading...'), findsOneWidget);
//   });

//   testWidgets('getMainQuestion displays data when fetched successfully',
//       (WidgetTester tester) async {
//     // Add a mock document to the collection
//     await mockFirestoreInstance.collection('mainquestions').add({
//       'query': 'Test question',
//     });

//     // Build the test widget
//     await tester.pumpWidget(_buildTestWidget('example_document_id'));

//     // Verify that the data is displayed correctly
//     expect(find.text('Test question'), findsOneWidget);
//   });
// }
