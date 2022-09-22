import 'dart:typed_data';
import 'package:flutter/material.dart';

class AuthMethods {

  Future<String> RegisterUser({
    required String email,
    required String password,
    required String username,
    required String bio,
   // required Uint8List file,
  }) async {
    String res = "Some error";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty) {
        // register
        res = "sucess";
      }
    } catch(err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> LoginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // register
      }
    } catch(err) {
      res = err.toString();
    }
    return res;
  }
}