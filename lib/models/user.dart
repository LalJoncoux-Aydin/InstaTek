import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  const User({
    required this.username,
    required this.uid,
    required this.avatarUrl,
    required this.email,
    required this.bio,
    required this.isAdmin,
    required this.followers,
    required this.following,
    required this.notification,
  });
  final String email;
  final String uid;
  final String avatarUrl;
  final String username;
  final String bio;
  final bool isAdmin;
  final List<dynamic> followers;
  final List<dynamic> following;
  final List<dynamic> notification;

  static User fromSnap(DocumentSnapshot<Object?> snap) {
    final Map<String, dynamic> snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      avatarUrl: snapshot["avatarUrl"],
      bio: snapshot["bio"],
      isAdmin: snapshot["isAdmin"],
      followers: snapshot["followers"],
      following: snapshot["following"],
      notification: snapshot["notification"],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "username": username,
        "uid": uid,
        "email": email,
        "avatarUrl": avatarUrl,
        "bio": bio,
        "isAdmin": isAdmin,
        "followers": followers,
        "following": following,
        "notification": notification,
      };
}
