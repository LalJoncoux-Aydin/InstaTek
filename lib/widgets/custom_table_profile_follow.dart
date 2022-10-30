import 'package:flutter/material.dart';
import 'package:instatek/utils/colors.dart';

class CustomTableProfileFollow extends StatelessWidget {
  const CustomTableProfileFollow({Key? key, required this.followers, required this.following, required this.postSize}) : super(key: key);

  final int followers;
  final int following;
  final int postSize;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    late double paddingNumber = 0;
    late double sizeLabel = 0;
    late double labelPadding = 0;

    if (size.width >= 1366) {
      paddingNumber = 50;
      sizeLabel = 30;
      labelPadding = 15;
    } else {
      paddingNumber = 10;
      sizeLabel = 18;
      labelPadding = 5;
    }

    return Expanded(
      flex: 2,
      child: Column(
        children: <Row>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Column>[
              buildStatColumn(postSize, "posts", paddingNumber, sizeLabel, labelPadding),
              buildStatColumn(followers, "followers", paddingNumber, sizeLabel, labelPadding),
              buildStatColumn(following, "following", paddingNumber, sizeLabel, labelPadding),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Text>[
              Text("Sign out"),
            ],
          ),
        ],
      ),
    );
  }

  Column buildStatColumn(int num, String label, double numPadding, double sizeLabel, double labelPadding) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: numPadding, vertical: numPadding),
        ),
        Text(
          num.toString(),
          style: TextStyle(
            fontSize: sizeLabel,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: labelPadding),
          child: Text(
            label,
            style: TextStyle(
              fontSize: sizeLabel - 2,
              fontWeight: FontWeight.w400,
              color: greyColor,
            ),
          ),
        ),
      ],
    );
  }
}
