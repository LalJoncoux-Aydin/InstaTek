import 'dart:typed_data';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instatek/models/user.dart' as model;
import 'package:instatek/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot = await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  Future<bool> usernameDoesntExist(username) async {
    QuerySnapshot querySnapshot = await _firestore.collection('users').get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    for (var user in allData) {
      String userStr = user.toString();
      String usernameOffset = userStr.substring(userStr.indexOf("username: "));
      String usernameOld = usernameOffset.substring(usernameOffset.indexOf(" ") + 1, usernameOffset.indexOf(",") == -1 ? usernameOffset.indexOf("}") : usernameOffset.indexOf(","));
      if (username == usernameOld) {
        return true;
      }
    }
    return false;
  }
  Future<bool> emailDoesntExist(email) async {
    QuerySnapshot querySnapshot = await _firestore.collection('users').get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    for (var user in allData) {
      String userStr = user.toString();
      String usernameOffset = userStr.substring(userStr.indexOf("email: "));
      String usernameOld = usernameOffset.substring(usernameOffset.indexOf(" ") + 1, usernameOffset.indexOf(",") == -1 ? usernameOffset.indexOf("}") : usernameOffset.indexOf(","));
      if (email == usernameOld) {
        return true;
      }
    }
    return false;
  }


  Future<String> registerUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    Uint8List? profilePicture,
  }) async {
    String res = "Internal unknown error.";
    try {
      if (await usernameDoesntExist(username)) {
        return "username-already-in-use";
      }
      else if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty && bio.isNotEmpty && profilePicture != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        String? photoUrl;
        if (profilePicture != null) {
          photoUrl = await StorageMethods().uploadImageToStorage('profilePics', profilePicture, false);
        }

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          photoUrl: photoUrl ?? '',
          email: email,
          bio: bio,
          followers: [],
          following: [],
        );

        await _firestore.collection("users").doc(cred.user!.uid).set(user.toJson());

        res = "Success";
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseAuthException catch(err) {
      res = err.code;
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Credentials are incorrect.";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "Success";
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseAuthException catch(err) {
      res = err.code;
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
