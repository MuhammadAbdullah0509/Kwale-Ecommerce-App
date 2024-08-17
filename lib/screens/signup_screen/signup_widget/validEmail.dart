import 'package:flutter/material.dart';

class ValidEmail{
  bool isValidEmail(String email) {
    // Simple email validation using regular expression
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

}