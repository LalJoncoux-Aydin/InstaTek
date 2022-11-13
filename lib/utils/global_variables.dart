import 'package:flutter/material.dart';
import 'package:instatek/screens/posts/addpost/add_post_screen.dart';
import 'package:instatek/screens/posts/feed/feed_screen.dart';
import '../screens/user/favorite/favorite_screen.dart';
import '../screens/user/profile/profile_screen.dart';
import '../screens/user/search/search_screen.dart';

int webScreenSize = 1366;
const String defaultAvatarUrl = 'https://cdn-icons-png.flaticon.com/512/847/847969.png';

List<Widget> homeScreenItems = <Widget>[
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const FavoriteScreen(),
  const ProfileScreen(),
];
