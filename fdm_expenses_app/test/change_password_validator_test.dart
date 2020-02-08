import 'package:fdm_expenses_app/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test('empty password returns error string', () {
    var result = Validator.emptyPassword('');
    expect(result, 'Enter a password');
  });

  test('non-empty password returns null', () {
    var result = Validator.emptyPassword("value");
    expect(result, null);
  }
  );

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

}
