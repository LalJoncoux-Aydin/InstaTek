import 'package:flutter/material.dart';
import 'package:instatek/models/user.dart';
import 'package:instatek/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  late User _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user;
  String get getUsername => _user.username;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}