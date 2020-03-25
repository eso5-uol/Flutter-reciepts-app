import 'package:fdm_expenses_app/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test('empty email returns error string', () {
    var result = Validator.emailSignIn('');
    expect(result, 'Enter an email');
  });

  test('valid email input returns null', () {
    var result = Validator.emailSignIn("value@gmail.com");
    expect(result, null);
  }
  );

  test('empty password returns error string', () {
    var result = Validator.emptyPassword('');
    expect(result, 'Enter a password');
  });

  test('non-empty password returns null', () {
    var result = Validator.emptyPassword("value");
    expect(result, null);
  });

  test('Invalid email address returns error message', () {
    var result = Validator.emailSignIn("base6740");
    expect(result, "Email is formatted badly!");
  });


}
