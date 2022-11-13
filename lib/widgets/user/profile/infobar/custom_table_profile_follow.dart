import 'package:flutter/material.dart';
import '../../../../utils/global_variables.dart';
import 'custom_table_column_profile_follow_widget.dart';

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

    if (size.width >= webScreenSize) {
      sizeLabel = 20;
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
            children: <Widget>[
              TableColumnProfileFollowWidget(num: postSize, label: "posts", numPadding: numPadding, sizeLabel: sizeLabel, labelPadding: labelPadding),
              TableColumnProfileFollowWidget(num: followers, label: "followers", numPadding: numPadding, sizeLabel: sizeLabel, labelPadding: labelPadding),
              TableColumnProfileFollowWidget(num: following, label: "following", numPadding: numPadding, sizeLabel: sizeLabel, labelPadding: labelPadding),
            ],
          ),
        ],
      ),
    );
  }
}
