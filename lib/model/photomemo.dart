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

  static String validateTitle(String value) {
    if (value == null || value.length < 3)
      return 'Too short.';
    else
      return null;
  }

  static String validateMemo(String value) {
    if (value == null || value.length < 5)
      return 'Too short.';
    else
      return null;
  }

  static String validateSharedWith(String value) {
    if (value == null || value.trim().length == 0) return null;

    List<String> emailList = value.split(RegExp('(,| )+')).map((e) => e.trim()).toList();
    for (String email in emailList) {
      if (email.contains('@') && email.contains('.'))
        continue;
      else
        return 'Comma(,) or space seperated email list';
    }
    return null;
  }
}
