import 'package:flutter_test/flutter_test.dart';
import 'package:random_password_generator/random_password_generator.dart';

void main() {
  test('', () {
    final password = RandomPasswordGenerator();
    String newPassword = password.randomPassword(
        letters: false,
        numbers: false,
        passwordLength: 20,
        specialChar: false,
        uppercase: false);
    print(newPassword);
    print(password.checkPassword(password: newPassword));
  });
}
