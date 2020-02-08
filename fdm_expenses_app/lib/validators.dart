class Validator {

  static String emptyEmail(String value) {
    return value.isEmpty ? 'Enter an email' : null;
  }

  static String emptyPassword(String value) {
    return value.isEmpty ? 'Enter a password' : null;
  }

  static String changePassword(String password) {

    if (password.isEmpty) {
      return "Enter a password";
    }

    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(password)) {
      return "Password does not meet the requirements";
    }
    return null;
  }

  static bool matchingPassword(String password1, String password2) {
    if (password1 == password2) {
      return true;
    } else {
      return false;
    }
  }
}
