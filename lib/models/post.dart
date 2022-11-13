import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.likes,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.avatarUrl,
  });
  final String description;
  final String uid;
  final String username;
  final List<dynamic> likes;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String avatarUrl;

  static Post fromSnap(DocumentSnapshot<Object?> snap) {
    final Map<String, dynamic> snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      description: snapshot["description"],
      uid: snapshot["uid"],
      likes: snapshot["likes"],
      postId: snapshot["postId"],
      datePublished: snapshot["datePublished"].toDate(),
      username: snapshot["username"],
      postUrl: snapshot['postUrl'],
      avatarUrl: snapshot['avatarUrl'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "description": description,
        "uid": uid,
        "likes": likes,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        'postUrl': postUrl,
        'avatarUrl': avatarUrl
      };
}
