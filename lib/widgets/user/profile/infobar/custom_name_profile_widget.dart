import 'package:flutter/material.dart';

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
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: paddingBio),
          child: Text(
            bio,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ],
    );
  }
}
