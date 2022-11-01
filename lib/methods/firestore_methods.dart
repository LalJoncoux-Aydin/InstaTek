import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instatek/methods/storage_methods.dart';
import 'package:instatek/models/post.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String avatarUrl,
  ) async {
    String res = "Some error occurred";
    try {
      final String postUrl = await StorageMethods().uploadImageToStorage('posts', file, true);
      final String postId = const Uuid().v4();
      final Post post = Post(
        description: description,
        uid: uid,
        username: username.toLowerCase(),
        likes: <String>[],
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: postUrl,
        avatarUrl: avatarUrl,
      );
      await _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> addOrRemoveLikeOnPost(String postId, String uid, List<dynamic> likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update(<String, Object?>{
          'likes': FieldValue.arrayRemove(<String>[uid])
        });
      } else {
        await _firestore.collection('posts').doc(postId).update(<String, Object?>{
          'likes': FieldValue.arrayUnion(<String>[uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> addCommentOnPost(
    String postId,
    String text,
    String uid,
    String name,
    String avatarUrl,
  ) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        final String commentId = const Uuid().v4();
        await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).set(<String, dynamic>{
          'avatarUrl': avatarUrl,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
