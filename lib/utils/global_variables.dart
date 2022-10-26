import 'package:flutter/material.dart';
import 'package:instatek/screens/add_post_screen.dart';
import 'package:instatek/screens/feed_screen.dart';

int webScreenSize = 600;

List<Widget> homeScreenItems = <Widget>[
  const FeedScreen(),
  const Text('search'),
  const AddPostScreen(),
  const Text('notif'),
  const Text('profile'),
];

List<Widget> adminScreenItems = <Widget>[
 const Text('posts'),
 const Text('users'),
 const Text('history'),
];