class FailedLogIn {
  late final bool message;
  late final String data;

  FailedLogIn();

  FailedLogIn.fromMap(Map m) {
    message = m['message'];
    data = m['data'];
  }
}
