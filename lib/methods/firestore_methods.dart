import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instatek/methods/storage_methods.dart';
import 'package:instatek/models/post.dart';
import 'package:instatek/models/user.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Post>> getFeedPosts() async {
    final QuerySnapshot<Map<String, dynamic>> documentSnapshot =
        await _firestore.collection('posts').get();
    List<Post> listPost = documentSnapshot.docs
        .map(
          (QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
              Post.fromSnap(doc),
        )
        .toList();
    listPost.sort(
      (Post a, Post b) =>
          a.datePublished.toString().compareTo(b.datePublished.toString()),
    );
    listPost = listPost.reversed.toList();
    return listPost;
  }

  Future<List<User?>> getUsers() async {
    final QuerySnapshot<Map<String, dynamic>> documentSnapshot =
        await _firestore.collection('users').get();
    final List<User?> userList = documentSnapshot.docs
        .map(
          (QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
              User.fromSnap(doc),
        )
        .toList();
    return userList;
  }

  Future<List<Post>?> getUserPosts(String uid) async {
    final QuerySnapshot<Map<String, dynamic>> documentSnapshot =
        await _firestore.collection('posts').where('uid', isEqualTo: uid).get();
    List<Post> listPost = documentSnapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
            Post.fromSnap(doc),)
        .toList();
    listPost.sort((Post a, Post b) =>
        a.datePublished.toString().compareTo(b.datePublished.toString()),);
    listPost = listPost.reversed.toList();
    return listPost;
  }

  Future<int> getPostCommentNb(String postId) async {
    final QuerySnapshot<Object?> comments = await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get();
    return comments.docs.length;
  }

  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String avatarUrl,
  ) async {
    String res = "Some error occurred";
    try {
      final String postUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
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

  Future<String> addOrRemoveLikeOnPost(
      String postId, String uid, List<dynamic> likes, bool isLiked,) async {
    String res = "Some error occurred";
    try {
      if (isLiked) {
        await _firestore
            .collection('posts')
            .doc(postId)
            .update(<String, Object?>{
          'likes': FieldValue.arrayRemove(<String>[uid])
        });
        res = 'remove';
      } else {
        await _firestore
            .collection('posts')
            .doc(postId)
            .update(<String, Object?>{
          'likes': FieldValue.arrayUnion(<String>[uid])
        });
        res = 'add';
      }
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
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set(<String, dynamic>{
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

  Future<String> deleteUser(String uid) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('users').doc(uid).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
