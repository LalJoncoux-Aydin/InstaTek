import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class CustomValidationButton extends StatelessWidget {
  const CustomValidationButton({
    Key? key,
    required this.displayText,
    required this.formKey,
    required this.loadingState,
    required this.onTapFunction,
    required this.shapeDecoration,
  }) : super(key: key);

  final String displayText;
  final GlobalKey<FormState> formKey;
  final bool loadingState;
  final void Function(GlobalKey<FormState>, BuildContext? context) onTapFunction;
  final ShapeDecoration? shapeDecoration;

  @override
  Widget build(BuildContext context) {
    ShapeDecoration? decorationButton = shapeDecoration;
    decorationButton ??= const ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        color: blueColor,
      );

    return Column(
      children: <Widget>[
        InkWell(
          onTap: () => onTapFunction(formKey, context),
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: decorationButton,
            child: !loadingState
                ? Text(displayText, style: const TextStyle(color: whiteColor))
                : const CircularProgressIndicator(color: primaryColor),
          ),
        ),
      ],
    );
  }
}
