class Validator {

  static String emptyEmail(String value) {
    return value.isEmpty ? 'Enter an email' : null;
  }

  static String emptyPassword(String value) {
    return value.isEmpty ? 'Enter a password' : null;
  }
}
