class PhotoMemo {
  String docId; // Firestore auto-generated ID
  String createdBy;
  String title;
  String memo;
  String photoFilename; // stored at Storage portion of Firestore
  String photoURL;
  DateTime timestamp;
  List<dynamic> sharedWith; // list of email addresses
  List<dynamic> imageLabels; // image identified by Machine Learning

  PhotoMemo({
    this.docId,
    this.createdBy,
    this.memo,
    this.photoFilename,
    this.photoURL,
    this.timestamp,
    this.sharedWith,
    this.imageLabels,
  }) {
    this.sharedWith ??= [];
    this.imageLabels ??= [];
  }
}
