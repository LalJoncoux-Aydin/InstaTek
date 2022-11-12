import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class CustomDeleteButton extends StatelessWidget {
  const CustomDeleteButton({
    Key? key,
    required this.displayText,
    required this.loadingState,
    required this.onTapFunction,
    required this.shapeDecoration,
  }) : super(key: key);

  final String displayText;
  final bool loadingState;
  final void Function(BuildContext context) onTapFunction;
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
      color: Colors.red,
    );

    return Column(
      children: <Widget>[
            const SizedBox(height: 12),
        InkWell(
          onTap: () => onTapFunction(context),
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
