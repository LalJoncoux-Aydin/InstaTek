import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<Uint8List> pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();

  final XFile? file = await imagePicker.pickImage(source: source);

  if (file != null) {
    return file.readAsBytes();
  }
  debugPrint('No image selected');
  return Future<Uint8List>.value(Uint8List(0));
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
