class Session {
  static final Session _instance = Session._internal();
  int? _userId;

  factory Session() {
    return _instance;
  }

  Session._internal();

  void setUserId(int userId) {
    _userId = userId;
  }

  int? get userId => _userId;
}
