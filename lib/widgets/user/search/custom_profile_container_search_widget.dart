import 'package:flutter/material.dart';
import 'package:instatek/models/user.dart' as model;

import '../../../utils/global_variables.dart';
import 'custom_profile_element_search_widget.dart';

class CustomProfileContainerSearch extends StatelessWidget {
  const CustomProfileContainerSearch({Key? key, required this.listResearch, required this.navigateToProfile}) : super(key: key);

  final List<model.User> listResearch;
  final void Function(String) navigateToProfile;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double paddingVertical = 0;
    double crossAxis = 0;
    double correctRatio = 0;
    if (size.width >= webScreenSize) {
      paddingVertical = 20;
      crossAxis = 300;
      correctRatio = MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height * 2.2);
    } else {
      paddingVertical = 20;
      crossAxis = 200;
      correctRatio = MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.4);
    }

    if (listResearch.isEmpty) {
      return const Text("No Result");
    } else {
      return Container(
        padding: EdgeInsets.only(top: paddingVertical),
        width: double.infinity,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: crossAxis,
            childAspectRatio: correctRatio,
          ),
          itemCount: listResearch.length,
          itemBuilder: (BuildContext ctx, int index) => CustomProfileElementSearch(displayUser: listResearch[index], navigateToProfile: navigateToProfile),
        ),
      );
    }
  }
}
