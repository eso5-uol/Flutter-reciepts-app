import 'package:fdm_expenses_app/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test('empty password returns error string', () {
    var result = Validator.changePassword('');
    expect(result, 'Enter a password');
  });
  
  test('matching passwords return true', () {
    var result = Validator.matchingPassword("password", "password");
    expect(result, true);
  }
  );

  test('different passwords return true', () {
    var result = Validator.matchingPassword("password", "different");
    expect(result, false);
  }
  );

  test('password matches all the requirements returns null', () {
    var result = Validator.changePassword("Pa55word!");
    expect(result, null);
  });

  test('password does not contain a lowercase returns error message', () {
    var result = Validator.changePassword("PA55WORD!");
    expect(result, "Password does not meet the requirements");
  });

  test('password does not contain a uppercase returns error message', () {
    var result = Validator.changePassword("pa55word!");
    expect(result, "Password does not meet the requirements");
  });

  test('password does not contain a number returns error message', () {
    var result = Validator.changePassword("Password!");
    expect(result, "Password does not meet the requirements");
  });

  test('password does not contain a special character returns error message', () {
    var result = Validator.changePassword("Pa55word");
    expect(result, "Password does not meet the requirements");
  });

}
