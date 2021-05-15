library random_password_generator;

import 'dart:math';

/// [Random Password Generator]
class RandomPasswordGenerator {
  /// get random password [randomPassword]
  String randomPassword(
      {bool letters = true,
      bool uppercase = false,
      bool numbers = false,
      bool specialChar = false,
      double passwordLength = 8}) {
    if (letters == false &&
        uppercase == false &&
        specialChar == false &&
        numbers == false) {
      letters = true;
    }
    String _lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz";
    String _upperCaseLetters = _lowerCaseLetters.toUpperCase();
    String _numbers = "0123456789";
    String _special = "@#=+!£\$%&?[](){}";
    String _allowedChars = "";
    _allowedChars += (letters ? _lowerCaseLetters : '');
    _allowedChars += (uppercase ? _upperCaseLetters : '');
    _allowedChars += (numbers ? _numbers : '');
    _allowedChars += (specialChar ? _special : '');

    int i = 0;
    String _result = "";
    while (i < passwordLength.round()) {
      int randomInt = Random.secure().nextInt(_allowedChars.length);
      _result += _allowedChars[randomInt];
      i++;
    }

    /// return random password
    return _result;
  }

  /// check password strong and retrun double value [0-1] input string [password]
  double checkPassword({required String password}) {
    /// if [password] is empty return 0.0
    if (password.isEmpty) return 0.0;

    double bonus;
    if (RegExp(r'^[a-z]*$').hasMatch(password)) {
      bonus = 1.0;
    } else if (RegExp(r'^[a-z0-9]*$').hasMatch(password)) {
      bonus = 1.2;
    } else if (RegExp(r'^[a-zA-Z]*$').hasMatch(password)) {
      bonus = 1.3;
    } else if (RegExp(r'^[a-z\-_!?]*$').hasMatch(password)) {
      bonus = 1.3;
    } else if (RegExp(r'^[a-zA-Z0-9]*$').hasMatch(password)) {
      bonus = 1.5;
    } else {
      bonus = 1.8;
    }

    /// return double value [0-1]
    final logistic = (double x) {
      return 1.0 / (1.0 + exp(-x));
    };

    /// return double value [0-1]
    final curve = (double x) {
      return logistic((x / 3.0) - 4.0);
    };

    /// return double value [0-1]
    return curve(password.length * bonus);
  }
}
