import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeLoginInfo(String username, String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('username', username);
  prefs.setString('token', token);
}
