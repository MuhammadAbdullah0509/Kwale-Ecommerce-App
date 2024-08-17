import 'package:flutter/material.dart';

class PasswordVisibilityProvider with ChangeNotifier {
  bool _hidePassword = true;

  bool get hidePassword => _hidePassword;

  void togglePasswordVisibility() {
    _hidePassword = !_hidePassword;
    notifyListeners();
  }
}
