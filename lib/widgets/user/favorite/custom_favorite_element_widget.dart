import 'package:flutter/material.dart';
import 'package:instatek/models/user.dart' as model;

import '../../../utils/global_variables.dart';
import '../profile/infobar/custom_profile_picture_profile.dart';

class CustomFavoriteElement extends StatelessWidget {
  const CustomFavoriteElement({Key? key, required this.notif}) : super(key: key);

  final model.User notif;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double paddingPosts = 0;
    double paddingRight = 0;
    if (size.width >= webScreenSize) {
      paddingPosts = 8;
      paddingRight = 25;
    } else {
      paddingPosts = 5;
      paddingRight = 20;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: paddingPosts),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: paddingRight),
            child: Text("${notif.username} just followed you"),
          ),
          CustomProfilePictureProfile(photoUrl: notif.avatarUrl)
        ],
      ),
    );
  }
}
