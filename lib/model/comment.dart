class Comment {
  String docId;
  String createdBy;
  String content;
  String photoDocId; // docId for photoMemo the comment belongs to
  DateTime timestamp;

  // Static keys for firestore
  static const CREATED_BY = 'createdBy';
  static const CONTENT = 'content';
  static const TIMESTAMP = 'timestamp';
  static const PHOTODOCID = 'photoDocId';

  // Constructor
  Comment({
    this.docId,
    this.createdBy,
    this.content,
    this.photoDocId,
    this.timestamp,
  });

  // From Dart obj to Firestore document
  Map<String, dynamic> serialize() {
    return <String, dynamic>{
      CREATED_BY: this.createdBy,
      CONTENT: this.content,
      TIMESTAMP: this.timestamp,
      PHOTODOCID: this.photoDocId,
    };
  }

  static Comment deserialize(Map<String, dynamic> doc, String docId) {
    return Comment(
      docId: docId,
      createdBy: doc[CREATED_BY],
      content: doc[CONTENT],
      timestamp: doc[TIMESTAMP] == null ? null : DateTime.fromMillisecondsSinceEpoch(doc[TIMESTAMP].millisecondsSinceEpoch),
    );
  }

  static String validateComment(String value) {
    if (value == null || value.length < 5)
      return 'Too short.';
    else
      return null;
  }
}
