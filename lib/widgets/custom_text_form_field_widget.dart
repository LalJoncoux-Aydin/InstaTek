import 'package:flutter/material.dart';
import '../utils/colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({Key? key, required this.hintText, required this.textEditingController, required this.isPass, required this.isValid, required this.updateInput}): super(key: key);

  final String hintText;
  final TextEditingController textEditingController;
  final bool isPass;
  final String? isValid;
  final void Function(String) updateInput;

  @override  Widget build(BuildContext context) {
    final OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context, color: blueColor),
    );

    return Column(
      children: <Widget>[
        const SizedBox(height: 10),
        TextFormField(
          validator: (String? value) {
            return isValid;
          },
          controller: textEditingController,
          onChanged: (String changedText) => updateInput(changedText),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 15, color: blueColor),
            border: inputBorder,
            focusedBorder: inputBorder,
            enabledBorder: inputBorder,
            filled: true,
            contentPadding: const EdgeInsets.all(20),
          ),
          keyboardType: TextInputType.text,
          obscureText: isPass,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}