import 'package:flutter/material.dart';

class CustomValidationButton extends StatelessWidget {
  const CustomValidationButton({
    Key? key,
    required this.displayText,
    required this.formKey,
    required this.loadingState,
    required this.onTapFunction,
  }) : super(key: key);

  final String displayText;
  final GlobalKey<FormState> formKey;
  final bool loadingState;
  final void Function(GlobalKey<FormState>) onTapFunction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 10),
        InkWell(
          onTap: () => onTapFunction(formKey),
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: ShapeDecoration(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              color: Theme.of(context).colorScheme.onBackground,
            ),
            child: !loadingState
                ? Text(
                    displayText,
                    style: Theme.of(context).textTheme.button!.copyWith(color: Theme.of(context).primaryColor),
                  )
                : CircularProgressIndicator(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
      ],
    );
  }
}
