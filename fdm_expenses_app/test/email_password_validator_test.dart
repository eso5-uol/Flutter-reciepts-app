import 'package:fdm_expenses_app/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test('empty email returns error string', () {
    var result = Validator.emptyEmail('');
    expect(result, 'Enter an email');
  });

  test('non-empty email returns null', () {
    var result = Validator.emptyEmail("value");
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
  }
  );

}
