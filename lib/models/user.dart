//import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  const User(
      {required this.username,
      required this.uid,
      required this.photoUrl,
      required this.email,
      required this.bio,
      required this.followers,
      required this.following,});
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List<dynamic> followers;
  final List<dynamic> following;

  static User? fromSnap(DocumentSnapshot<Object?> snap) {
    if (snap.data() != null) {
      final Map<String, dynamic> snapshot = snap.data() as Map<String, dynamic>;

      return User(
        username: snapshot["username"],
        uid: snapshot["uid"],
        email: snapshot["email"],
        photoUrl: snapshot["photoUrl"],
        bio: snapshot["bio"],
        followers: snapshot["followers"],
        following: snapshot["following"],
      );
    } else {
      return null;
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic> {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
      };
}
