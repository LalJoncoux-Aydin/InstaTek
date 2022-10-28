import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instatek/screens/add_post_screen.dart';
import 'package:instatek/screens/feed_screen.dart';
import '../screens/profile_screen.dart';

int webScreenSize = 600;
const String defaultAvatarUrl = 'https://cdn-icons-png.flaticon.com/512/847/847969.png';

List<Widget> homeScreenItems = <Widget>[
  const FeedScreen(),
  const Text('search'),
  const AddPostScreen(),
  const Text('notif'),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
