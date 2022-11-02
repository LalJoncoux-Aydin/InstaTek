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
    late double sizeLabel = 0;
    late double labelPadding = 0;
    late double numPadding = 0;

    if (size.width >= 1366) {
      sizeLabel = 30;
      numPadding = 5;
      labelPadding = 5;
    } else {
      sizeLabel = 18;
      numPadding = 3;
      labelPadding = 3;
    }

    return Expanded(
      flex: 2,
      child: Column(
        children: <Row>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Column>[
              buildStatColumn(postSize, "posts", numPadding, sizeLabel, labelPadding),
              buildStatColumn(followers, "followers", numPadding, sizeLabel, labelPadding),
              buildStatColumn(following, "following", numPadding, sizeLabel, labelPadding),
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
      children: <Container>[
        Container(
          margin: EdgeInsets.only(bottom: numPadding),
          child: Text(
            num.toString(),
            style: TextStyle(
              fontSize: sizeLabel,
              fontWeight: FontWeight.bold,
              color: whiteColor,
            ),
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
