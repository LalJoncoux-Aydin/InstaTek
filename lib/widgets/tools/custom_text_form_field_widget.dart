import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.textEditingController,
    required this.isPass,
    required this.isValid,
    required this.updateInput,
  }) : super(key: key);

  final String hintText;
  final TextEditingController textEditingController;
  final bool isPass;
  final String? isValid;
  final void Function(String) updateInput;

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context, color: Theme.of(context).colorScheme.tertiary),
    );
    final Size size = MediaQuery.of(context).size;
    double paddingVertical = 0;
    if (size.width >= 1366) {
      paddingVertical = 20;
    } else {
      paddingVertical = 10;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: paddingVertical),
      child: TextFormField(
          validator: (String? value) {
            return isValid;
          },
          controller: textEditingController,
          onChanged: (String changedText) => updateInput(changedText),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.subtitle1,
            border: inputBorder,
            focusedBorder: inputBorder,
            enabledBorder: inputBorder,
            filled: true,
            contentPadding: const EdgeInsets.all(20),
          ),
          keyboardType: TextInputType.text,
          obscureText: isPass,
        ),
    );
  }
}
