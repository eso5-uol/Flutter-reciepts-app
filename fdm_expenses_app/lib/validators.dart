class Validator {

  static String emptyEmail(String value) {
    return value.isEmpty ? 'Enter an email' : null;
  }

  static String emptyPassword(String value) {
    return value.isEmpty ? 'Enter a password' : null;
  }

  static String changePassword(String password1, String password2) {

    if (password1.isEmpty || password2.isEmpty) {
      return "Enter a password";
    }
    return
  }
}
