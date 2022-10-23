import 'package:flutter/material.dart';
import 'package:instatek/methods/auth_methods.dart';
import 'package:instatek/models/user.dart';

class UserProvider with ChangeNotifier {
  late User _user;
  final AuthMethods _authMethods = AuthMethods();
  late bool isUser = false;

  User get getUser => _user;
  String get getUsername => _user.username;

  Future<void> refreshUser() async {
    final User? user = await _authMethods.getUserDetails();
    if (user != null) {
      _user = user;
      notifyListeners();
      isUser = true;
    } else {
      isUser = false;
    }
  }
}