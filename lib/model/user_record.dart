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

  @override
  String toString() {
    return 'UserRecord[email=$email password=$password]';
  }

  static List<UserRecord> fakeDB = [
    UserRecord(email: '1@test.com', password: '111111', name: 'One', phone: '1112223333'),
    UserRecord(email: '2@test.com', password: '222222', name: 'Two', phone: '2223334444'),
  ];
}
