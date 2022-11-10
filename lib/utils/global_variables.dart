import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instatek/screens/posts/addpost/add_post_screen.dart';
import 'package:instatek/screens/posts/feed/feed_screen.dart';
import '../screens/user/profile/profile_screen.dart';

int webScreenSize = 600;
const String defaultAvatarUrl = 'https://cdn-icons-png.flaticon.com/512/847/847969.png';

List<Widget> homeScreenItems = <Widget>[
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
  const FeedScreen(),
  const Text('search'),
  const AddPostScreen(),
  const Text('notif'),
];
