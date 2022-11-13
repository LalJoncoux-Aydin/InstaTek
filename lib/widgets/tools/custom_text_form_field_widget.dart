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

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
          validator: (String? value) {
            return isValid;
          },
          cursorColor: Theme.of(context).colorScheme.tertiary,
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
