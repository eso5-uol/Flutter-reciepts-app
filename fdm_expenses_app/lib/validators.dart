class Validator {

  static String emailSignIn(String value) {

    String pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";

    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty == false && !regExp.hasMatch(value)) {
      return "Email is formatted badly!";
    }

    return value.isEmpty ? 'Enter an email' : null;
  }

  static String emptyPassword(String value) {
    return value.isEmpty ? 'Enter a password' : null;
  }

  static String changePassword(String password) {

    if (password.isEmpty) {
      return "Enter a password";
    }

    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.]).{8,}$';
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
  
    static bool currencyEmpty(double currency, int i){
    i = currency.toString();
    if (i.isEmpty) {
      return "Enter a currency";
    }
  }

  static bool currencyFormat(double currency, int i){
    i = currency;
    int length = i.toString.length;
    if (length == 4) {
      return false; //it is the correct format. e.g. 33.43 has a length of 4
    } else {
      return true; //it is the wrong format. e.g. 33.436 has a length of 5
    }
  }

  static bool stringEmpty(string stringEntered){

    if (stringEntered.isEmpty) {
      return "Enter a currency";
    }
  }
}
