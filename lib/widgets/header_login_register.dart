import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeaderLoginRegister extends StatelessWidget {
  const HeaderLoginRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        SvgPicture.asset(
          'assets/instatek_logo.svg',
          height: 60,
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
