import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:instatek/utils/global_variables.dart';

class CustomImagePicker extends StatelessWidget {
  const CustomImagePicker({Key? key, required this.imagePick, required this.onPressedFunction}) : super(key: key);

  final Uint8List? imagePick;
  final void Function() onPressedFunction;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double avatarRadius = 80;
    double paddingBottom = 0;
    double paddingTop = 0;
    if (size.width >= webScreenSize) {
      paddingBottom = 20;
      paddingTop = 50;
    } else {
      paddingBottom = 20;
      paddingTop = 20;
    }

    return Container(
      padding: EdgeInsets.only(bottom: paddingBottom, top: paddingTop),
      child: Stack(
        children: <Widget>[
          if (imagePick != null)
            CircleAvatar(
              radius: avatarRadius,
              backgroundImage: MemoryImage(imagePick!),
              backgroundColor: Theme.of(context).colorScheme.background,
            )
          else
            const CircleAvatar(
              radius: avatarRadius,
              backgroundImage: NetworkImage(
                defaultAvatarUrl,
              ),
              // backgroundColor: Colors.red,
            ),
          Positioned(
            bottom: -10,
            left: 100,
            child: IconButton(
              onPressed: onPressedFunction,
              icon: const Icon(
                Icons.add_a_photo,
              ),
            ),
          )
        ],
      ),
    );
  }
}
