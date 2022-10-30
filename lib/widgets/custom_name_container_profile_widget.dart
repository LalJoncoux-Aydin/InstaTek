import 'package:flutter/cupertino.dart';

class CustomNameContainerProfile extends StatelessWidget {
  const CustomNameContainerProfile({Key? key, required this.username, required this.bio}) : super(key: key);

  final String username;
  final String bio;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double paddingGlobal = 0;
    double paddingTopName = 0;
    double paddingTopBio = 0;
    if (size.width >= 1366) {
      paddingGlobal = 10;
    } else {
      paddingGlobal = 10;
      paddingTopName = 10;
      paddingTopBio = 1;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingGlobal),
      width: double.infinity,
      child: Column(
        children: <Container>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: paddingTopName),
            child: Text(
              username,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: paddingTopBio),
            child: Text(
                bio,
            ),
          ),
        ],
      ),
    );
  }
}
