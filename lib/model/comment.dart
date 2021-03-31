class Comment {
  String docId;
  String createdBy;
  String content;
  String photoDocId; // docId for photoMemo the comment belongs to
  DateTime timestamp;

  static String validateComment(String value) {
    if (value == null || value.length < 5)
      return 'Too short.';
    else
      return null;
  }
}
