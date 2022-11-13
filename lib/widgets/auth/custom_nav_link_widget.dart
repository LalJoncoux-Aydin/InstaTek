import 'package:flutter/material.dart';

import '../../utils/global_variables.dart';

class CustomNavLink extends StatelessWidget {
  const CustomNavLink({Key? key, required this.displayText1, required this.displayText2, required this.onTapFunction})
      : super(key: key);

  final String displayText1;
  final String displayText2;
  final void Function() onTapFunction;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double paddingVertical = 0;
    if (size.width >= webScreenSize) {
      paddingVertical = 20;
    } else {
      paddingVertical = 20;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: paddingVertical),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(displayText1, style: Theme.of(context).textTheme.subtitle1),
          ),
          GestureDetector(
            onTap: onTapFunction,
            child: Text(displayText2, style: Theme.of(context).textTheme.subtitle2),
          )
        ],
      ),
    );
  }
}
