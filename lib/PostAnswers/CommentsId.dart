


//the CommentsId class provides a way to set and retrieve the ID of a comment.
// It encapsulates the logic for managing the comment ID within its private variable _commentsId
// and exposes a method setId to set the ID and return it if needed.
class CommentsId {
  String? _commentsId;
  setId(String id) {
    _commentsId = id;
    return _commentsId;
  }
}
