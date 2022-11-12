import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeaderLoginRegister extends StatelessWidget {
  const HeaderLoginRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double imageSize = 0;
    if (size.width >= 1366) {
      imageSize = 120;
    } else {
      imageSize = 90;
    }

    return Container(
      padding: const EdgeInsets.only(bottom: 40),
      child: SvgPicture.asset(
        'assets/instatek_logo.svg',
        height: imageSize,
      ),
    );
  }
}
