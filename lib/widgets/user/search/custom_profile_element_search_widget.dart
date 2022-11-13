import 'package:flutter/material.dart';
import 'package:instatek/models/user.dart' as model;

import '../../../utils/global_variables.dart';

class CustomProfileElementSearch extends StatelessWidget {
  const CustomProfileElementSearch({Key? key, required this.displayUser, required this.navigateToProfile}) : super(key: key);

  final model.User displayUser;
  final void Function(String) navigateToProfile;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double paddingPosts = 0;
    double paddingGlobal = 0;
    if (size.width >= webScreenSize) {
      paddingPosts = 5;
      paddingGlobal = 5;
    } else {
      paddingPosts = 5;
      paddingGlobal = 5;
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: paddingGlobal, vertical: paddingGlobal),
        width: double.infinity,
        child: GestureDetector(
          onTap: () => navigateToProfile(displayUser.uid),
          child: Column(
            children: <Widget>[
              Image.network(displayUser.avatarUrl, height: 110, width: 110),
              Container(
                padding: EdgeInsets.only(top: paddingPosts),
                child: Text(displayUser.username),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
