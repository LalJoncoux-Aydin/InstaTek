import 'package:flutter/material.dart';

class CustomErrorText extends StatelessWidget {
  const CustomErrorText({Key? key, required this.displayStr}) : super(key: key);

  final String displayStr;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double paddingVertical = 0;
    if (size.width >= 1366) {
      paddingVertical = 20;
    } else {
      paddingVertical = 10;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: paddingVertical),
      child: Text(displayStr, style: Theme.of(context).textTheme.headline2),
    );
  }
}
