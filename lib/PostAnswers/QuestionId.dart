////the QuestionId class provides a way to set and retrieve the ID of a question.
// // It encapsulates the logic for managing the question ID within its private variable _questionId
// // and exposes a method setId to set the ID and return it if needed.
class QuestionId {
  String? _questionId;
  setId(String id) {
    _questionId = id;
    return _questionId;
  }
}
