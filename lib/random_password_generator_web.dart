import 'dart:async';
import 'dart:math';
// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// A web implementation of the RandomPasswordGenerator plugin.
class RandomPasswordGeneratorWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'random_password_generator',
      const StandardMethodCodec(),
      registrar.messenger,
    );

    final pluginInstance = RandomPasswordGeneratorWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  /// Handles method calls over the MethodChannel of this plugin.
  /// Note: Check the "federated" architecture for a new way of doing this:
  /// https://flutter.dev/go/federated-plugins
  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'getPlatformVersion':
        return getPlatformVersion();
        break;
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details:
              'random_password_generator for web doesn\'t implement \'${call.method}\'',
        );
    }
  }

  /// Returns a [String] containing the version of the platform.
  Future<String> getPlatformVersion() {
    final version = html.window.navigator.userAgent;
    return Future.value(version);
  }

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
