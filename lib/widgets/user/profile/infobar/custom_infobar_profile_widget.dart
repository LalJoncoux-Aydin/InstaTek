import 'package:flutter/material.dart';
import 'custom_name_profile_widget.dart';
import 'custom_profile_picture_profile.dart';
import 'custom_table_profile_follow.dart';

class CustomInfobarProfile extends StatelessWidget {
  const CustomInfobarProfile({Key? key, required this.photoUrl, required this.followers, required this.following, required this.postSize, required this.username, required this.bio}) : super(key: key);

  final String photoUrl;
  final int followers;
  final int following;
  final int postSize;
  final String username;
  final String bio;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double paddingGlobal = 0;
    double paddingImageTable = 0;
    double paddingName = 0;
    if (size.width >= 1366) {
      paddingGlobal = 30;
      paddingImageTable = 10;
      paddingName = 10;
    } else {
      paddingGlobal = 20;
      paddingImageTable = 2;
      paddingName = 15;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingGlobal),
      child: Column(
        children: <Container>[
          Container(
            padding: EdgeInsets.only(top: paddingImageTable),
            width: double.infinity,
            child: Row(
              children: <Widget>[
                CustomProfilePictureProfile(photoUrl: photoUrl),
                CustomTableProfileFollow(followers: followers, following: following, postSize: postSize),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: paddingName),
            width: double.infinity,
            child: CustomNameProfile(username: username, bio: bio),
          ),
        ],
      ),
    );
  }

}
