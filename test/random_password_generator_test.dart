import 'package:flutter_test/flutter_test.dart';
import 'package:random_password_generator/random_password_generator.dart';

void main() {
  test('', () {
    final password = RandomPasswordGenerator();
    String newPassword =
        password.random_password(false, false, false, false, 20);
    print(newPassword);
    print(password.check_password(newPassword));
  });
}
