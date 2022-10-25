import 'package:flutter/cupertino.dart';

class CustomErrorText extends StatelessWidget {
  const CustomErrorText({Key? key, required this.displayStr}) : super(key: key);

  final String displayStr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 10),
        Text(displayStr),
        const SizedBox(height: 10),
      ],
    );
  }
}
