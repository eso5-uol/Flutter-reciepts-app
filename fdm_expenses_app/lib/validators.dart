class Validator {

  static String emptyEmail(String value) {
    return value.isEmpty ? 'Enter an email' : null;
  }

  static String emptyPassword(String value) {
    return value.isEmpty ? 'Enter a password' : null;
  }

  static bool matchingPassword(String password1, String password2) {
    if (password1 == password2) {
      return true;
    } else {
      return false;
    }
  }
}
