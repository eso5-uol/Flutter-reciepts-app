class Validator {
  static String emptyString(String value) {
    return value.isEmpty ? 'Field cannot be empty' : null;
  }
}
