import 'dart:typed_data';
import 'package:flutter/material.dart';

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
            if (imagePick != null) CircleAvatar(
              radius: 64,
              backgroundImage: MemoryImage(imagePick!),
              backgroundColor: Colors.red,
            ) else const CircleAvatar(
              radius: 64,
              backgroundImage: NetworkImage(
                'https://cdn-icons-png.flaticon.com/512/847/847969.png',),
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
