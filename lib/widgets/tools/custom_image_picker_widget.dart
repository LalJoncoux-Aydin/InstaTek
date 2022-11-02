import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:instatek/utils/global_variables.dart';

class CustomImagePicker extends StatelessWidget {
  const CustomImagePicker({Key? key, required this.imagePick, required this.onPressedFunction}) : super(key: key);

  final Uint8List? imagePick;
  final void Function() onPressedFunction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // image input
        const SizedBox(height: 10),
        Stack(
          children: <Widget>[
            if (imagePick != null)
              CircleAvatar(
                radius: 64,
                backgroundImage: MemoryImage(imagePick!),
                backgroundColor: Theme.of(context).colorScheme.background,
              )
            else
              const CircleAvatar(
                radius: 64,
                backgroundImage: NetworkImage(
                  defaultAvatarUrl,
                ),
                // backgroundColor: Colors.red,
              ),
            Positioned(
              bottom: -10,
              left: 80,
              child: IconButton(
                onPressed: onPressedFunction,
                icon: const Icon(
                  Icons.add_a_photo,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
