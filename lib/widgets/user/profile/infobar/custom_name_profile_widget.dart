import 'package:flutter/cupertino.dart';

import '../../../../utils/colors.dart';

class CustomNameProfile extends StatelessWidget {
  const CustomNameProfile({Key? key, required this.username, required this.bio}) : super(key: key);

  final String username;
  final String bio;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double paddingName = 0;
    double paddingBio = 0;
    if (size.width >= 1366) {
      paddingName = 10;
      paddingBio = 10;
    } else {
      paddingName = 1;
      paddingBio = 2;
    }

    return Column(
      children: <Container>[
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: paddingName),
          child: Text(
            username,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: whiteColor,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: paddingBio),
          child: Text(
            bio,
            style: const TextStyle(
              color: whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}
