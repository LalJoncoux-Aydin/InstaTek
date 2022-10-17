import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:instatek/methods/auth_methods.dart';
import 'package:instatek/screens/login_screen.dart';
import 'package:test/test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runTestAuthentification();
}

void runTestAuthentification() async {
  bool result = await AuthMethods().usernameDoesntExist("tutu458");

  test('This username shouldnt exist.', () {
    expect(result, true);
  });
}