import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeaderLoginRegister extends StatelessWidget {
  const HeaderLoginRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 30),
        SvgPicture.asset(
          'assets/instatek_logo.svg',
          color: Theme.of(context).colorScheme.secondary,
          height: 60,
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
