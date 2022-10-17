import 'package:flutter/material.dart';
import 'package:instatek/models/user.dart';
import 'package:instatek/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  late User _user;
  final AuthMethods _authMethods = AuthMethods();
  late bool isUser = false;

  User get getUser => _user;
  String get getUsername => _user.username;

  Future<void> refreshUser() async {
    User? user = await _authMethods.getUserDetails();
    if (user != null) {
      _user = user;
      notifyListeners();
      isUser = true;
    } else {
      isUser = false;
    }
  }
}