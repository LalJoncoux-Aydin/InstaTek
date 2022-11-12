import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeaderLoginRegister extends StatelessWidget {
  const HeaderLoginRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double paddingBottom = 0;
    double imageSize = 0;
    if (size.width >= 1366) {
      paddingBottom = 500;
      imageSize = 80;
    } else {
      paddingBottom = 60;
      imageSize = 60;
    }

    return Container(
      padding: EdgeInsets.only(bottom: paddingBottom),
      child: SvgPicture.asset(
        'assets/instatek_logo.svg',
        height: imageSize,
      ),
    );
  }
}
