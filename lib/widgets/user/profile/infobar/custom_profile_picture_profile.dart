import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:instatek/utils/colors.dart';

class CustomProfilePictureProfile extends StatelessWidget {
  const CustomProfilePictureProfile({Key? key, required this.photoUrl}) : super(key: key);

  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    const double radiusImage = 40;

    return CircleAvatar(
        backgroundColor: greyColor,
        backgroundImage: NetworkImage(photoUrl),
        radius: radiusImage,
    );
  }
}
