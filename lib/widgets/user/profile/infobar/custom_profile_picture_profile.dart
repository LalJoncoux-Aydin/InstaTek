import 'package:flutter/material.dart';
import 'package:instatek/utils/colors.dart';

import '../../../../utils/global_variables.dart';

class CustomProfilePictureProfile extends StatelessWidget {
  const CustomProfilePictureProfile({Key? key, required this.photoUrl}) : super(key: key);

  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double radiusImage = 0;
    if (size.width >= webScreenSize) {
      radiusImage = 50;
    } else {
      radiusImage = 40;
    }

    return CircleAvatar(
        backgroundColor: greyColor,
        backgroundImage: NetworkImage(photoUrl),
        radius: radiusImage,
    );
  }
}
