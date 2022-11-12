import 'package:flutter/material.dart';

class CustomNavLink extends StatelessWidget {
  const CustomNavLink({Key? key, required this.displayText1, required this.displayText2, required this.onTapFunction})
      : super(key: key);

  final String displayText1;
  final String displayText2;
  final void Function() onTapFunction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              //padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 8),
              child: Text(displayText1, style: Theme.of(context).textTheme.subtitle1),
            ),
            GestureDetector(
              onTap: onTapFunction,
              child: Container(
                //padding: const EdgeInsets.symmetric(vertical: 25),
                child: Text(displayText2, style: Theme.of(context).textTheme.subtitle2),
              ),
            )
          ],
        ),
        //const SizedBox(height: 24),
      ],
    );
  }
}
