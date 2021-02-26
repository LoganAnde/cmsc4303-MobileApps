enum Classification {
  Freshman,
  Sophomore,
  Junior,
  Senior,
  Graduate,
}

enum Major {
  CS,
  SE,
  DS,
  Other,
}

enum Language {
  Dart,
  Java,
  JavaScript,
  Cpp,
  Csharp,
}

class UserRecord {
  String email;
  String password;
  String name;
  String phone;
  int age;
  Classification classification;
  Major major;
  Map languages;

  UserRecord({
    this.email = '',
    this.password = '',
    this.name = '',
    this.phone = '',
    this.age = -1,
    this.classification = Classification.Freshman,
    this.major = Major.CS,
  }) {
    languages = {};
    Language.values.forEach((e) => languages[e] = false);
  }

  UserRecord.clone(UserRecord user) {
    this.email = user.email;
    this.password = user.password;
    this.name = user.name;
    this.phone = user.phone;
    this.age = user.age;
    this.classification = user.classification;
    this.major = user.major;
    // this.languages = user.languages; // Shallow copy
    this.languages = {};
    Language.values.forEach((e) => this.languages[e] = user.languages[e]);
  }

  @override
  String toString() {
    return 'UserRecord[email=$email password=$password]';
  }

  static List<UserRecord> fakeDB = [
    UserRecord(email: '1@test.com', password: '111111', name: 'One', phone: '1112223333'),
    UserRecord(email: '2@test.com', password: '222222', name: 'Two', phone: '2223334444'),
  ];
}
