import 'package:flutter/material.dart';
import 'package:instatek/utils/colors.dart';

class CustomProfilePictureProfile extends StatelessWidget {
  const CustomProfilePictureProfile({Key? key, required this.photoUrl}) : super(key: key);

  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    const double radiusImage = 40;

    final Size size = MediaQuery.of(context).size;
    double paddingPicture = 0;
    if (size.width >= 1366) {
      paddingPicture = 50;
    } else {
      paddingPicture = 10;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingPicture),
      width: double.infinity,
      child: CircleAvatar(
        backgroundColor: greyColor,
        backgroundImage: NetworkImage(photoUrl),
        radius: radiusImage,
      ),
    );
  }
}
