import 'package:flutter/material.dart';
import 'custom_profile_picture_profile.dart';
import 'custom_table_profile_follow.dart';

class CustomHeaderProfile extends StatelessWidget {
  const CustomHeaderProfile({Key? key, required this.photoUrl, required this.followers, required this.following}) : super(key: key);

  final String photoUrl;
  final int followers;
  final int following;

  @override
  Widget build(BuildContext context) {
    //final Size size = MediaQuery.of(context).size;
    const double paddingHeader = 10;
/*    if (size.width >= 1366) {
      paddingHeader = 50;
    } else {
      paddingHeader = 10;
    }*/

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: paddingHeader),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          CustomProfilePictureProfile(photoUrl: photoUrl),
          CustomTableProfileFollow(followers: followers, following: following),
        ],
      ),
    );
  }

}
