import 'package:flutter/material.dart';

import '../utils/colors.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  const TextFieldInput({Key? key, required this.textEditingController, this.isPass = false, required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context, color: blueColor)
    );
    return Column(
      children: [
        SizedBox(height: 10),
        TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 15, color: blueColor),
            border: inputBorder,
            focusedBorder: inputBorder,
            enabledBorder: inputBorder,
            filled: true,
            contentPadding: const EdgeInsets.all(20),
          ),
          keyboardType: TextInputType.text,
          obscureText: isPass,
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
