import 'package:fdm_expenses_app/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test('Empty currency returns error string', () {
    var result = Validator.currencyEmpty('');
    expect(result, 'Enter an amount of currency');
  });

  test('Invalid format of currency', () {
    var result = Validator.currencyFormat(12.345);
    expect(result, "Currency is formatted badly!");
  });

  test('Invalid format of date', () {
    var result = Validator.currencyFormat(12.345);
    expect(result, "Date is formatted badly!");
  });

  test('Empty date returns error string', () {
    var result = Validator.currencyEmpty('');
    expect(result, 'Enter a date');
  });

  test('Empty name returns error string', () {
    var result = Validator.stringEmpty('');
    expect(result, 'Enter a full name');
  });

  test('Empty justification returns error string', () {
    var result = Validator.stringEmpty('');
    expect(result, 'Enter a justification');
  });

  test('Invalid format of milaged claimed', () {
    var result = Validator.currencyFormat(12.345);
    expect(result, "mileaged is formatted badly!");
  });

  test('Empty mileaged claimed returns error string', () {
    var result = Validator.currencyEmpty('');
    expect(result, 'Enter an amount of milaged claimed');
  });

  test('Invalid format of milage claimed', () {
    var result = Validator.currencyFormat(12.345);
    expect(result, "milage claimed is formatted badly!");
  });

  test('Empty mileage claimed returns error string', () {
    var result = Validator.currencyEmpty('');
    expect(result, 'Enter an amount of milage claimed');
  });

  test('Invalid format of flights', () {
    var result = Validator.currencyFormat(12.345);
    expect(result, "flights is formatted badly!");
  });

  test('Empty flights claimed returns error string', () {
    var result = Validator.currencyEmpty('');
    expect(result, 'Enter an amount of flights');
  });

  test('Invalid format of other travel', () {
    var result = Validator.currencyFormat(12.345);
    expect(result, "other travel is formatted badly!");
  });

  test('Empty other travel claimed returns error string', () {
    var result = Validator.currencyEmpty('');
    expect(result, 'Enter an amount of other travel');
  });

  test('Invalid format of accomodation', () {
    var result = Validator.currencyFormat(12.345);
    expect(result, "accomodation is formatted badly!");
  });

  test('Empty accomodation claimed returns error string', () {
    var result = Validator.currencyEmpty('');
    expect(result, 'Enter an amount of accomodation');
  });

  test('Invalid format of subsistence', () {
    var result = Validator.currencyFormat(12.345);
    expect(result, "subsistence is formatted badly!");
  });

  test('Empty subsistence claimed returns error string', () {
    var result = Validator.currencyEmpty('');
    expect(result, 'Enter an amount of subsistence');
  });

  test('Invalid format of staff entertaining', () {
    var result = Validator.currencyFormat(12.345);
    expect(result, "staff entertaining is formatted badly!");
  });

  test('Empty staff entertaining claimed returns error string', () {
    var result = Validator.currencyEmpty('');
    expect(result, 'Enter an amount of staff entertaining');
  });

  test('Invalid format of client entertaining', () {
    var result = Validator.currencyFormat(12.345);
    expect(result, "client entertaining is formatted badly!");
  });

  test('Empty client entertaining claimed returns error string', () {
    var result = Validator.currencyEmpty('');
    expect(result, 'Enter an amount of client entertaining');
  });

  test('Invalid format of other', () {
    var result = Validator.currencyFormat(12.345);
    expect(result, "other is formatted badly!");
  });

  test('Empty other claimed returns error string', () {
    var result = Validator.currencyEmpty('');
    expect(result, 'Enter an amount of other');
  });

  test('Invalid format of VAT', () {
    var result = Validator.currencyFormat(12.345);
    expect(result, "VAT is formatted badly!");
  });

  test('Empty VAT claimed returns error string', () {
    var result = Validator.currencyEmpty('');
    expect(result, 'Enter an amount of VAT');
  });

}
