import 'package:fdm_expenses_app/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test('Empty currency returns error string', () {
    var result = Validator.currencyAmount('');
    expect(result, 'Enter an amount of currency');
  });

  test('Invalid format of currency', () {
    var result = Validator.currencyFormat("£00.000");
    expect(result, "Currency is formatted badly!");
  });

  test('Invalid format of date', () {
    var result = Validator.dateFormat("01/01/20");
    expect(result, "Date is formatted badly!");
  });

  test('Empty date returns error string', () {
    var result = Validator.dateFormat('');
    expect(result, 'Enter a date');
  });

  test('Invalid format of name', () {
    var result = Validator.dateFormat("firstName");
    expect(result, "Name is formatted badly!");
  });

  test('Empty name returns error string', () {
    var result = Validator.dateFormat('');
    expect(result, 'Enter a full name');
  });

  test('Empty justification returns error string', () {
    var result = Validator.dateFormat('');
    expect(result, 'Enter a justification');
  });

  test('Invalid format of milaged claimed', () {
    var result = Validator.dateFormat("£00.000");
    expect(result, "mileaged is formatted badly!");
  });

  test('Empty mileaged claimed returns error string', () {
    var result = Validator.dateFormat('');
    expect(result, 'Enter an amount of milaged claimed');
  });

  test('Invalid format of milage claimed', () {
    var result = Validator.dateFormat("£00.000");
    expect(result, "milage claimed is formatted badly!");
  });

  test('Empty mileage claimed returns error string', () {
    var result = Validator.dateFormat('');
    expect(result, 'Enter an amount of milage claimed');
  });

}
