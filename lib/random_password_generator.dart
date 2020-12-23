library random_password_generator;

import 'dart:math';

class RandomPasswordGenerator {
  String random_password(bool _isWithLetters, bool _isWithUppercase,
      bool _isWithNumbers, bool _isWithSpecial, double _numberCharPassword) {
    if (_isWithLetters == false &&
        _isWithUppercase == false &&
        _isWithSpecial == false &&
        _isWithNumbers == false) {
      _isWithLetters = true;
    }
    String _lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz";
    String _upperCaseLetters = _lowerCaseLetters.toUpperCase();
    String _numbers = "0123456789";
    String _special = "@#=+!£\$%&?[](){}";
    String _allowedChars = "";
    _allowedChars += (_isWithLetters ? _lowerCaseLetters : '');
    _allowedChars += (_isWithUppercase ? _upperCaseLetters : '');
    _allowedChars += (_isWithNumbers ? _numbers : '');
    _allowedChars += (_isWithSpecial ? _special : '');

    int i = 0;
    String _result = "";
    while (i < _numberCharPassword.round()) {
      int randomInt = Random.secure().nextInt(_allowedChars.length);
      _result += _allowedChars[randomInt];
      i++;
    }

    return _result;
  }

  double check_password(String password) {
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

    final logistic = (double x) {
      return 1.0 / (1.0 + exp(-x));
    };

    final curve = (double x) {
      return logistic((x / 3.0) - 4.0);
    };

    return curve(password.length * bonus);
  }
}
