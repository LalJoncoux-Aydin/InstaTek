import 'package:flutter/cupertino.dart';
import 'package:instatek/models/user.dart' as model;
import 'package:instatek/widgets/user/favorite/custom_favorite_element_widget.dart';

import '../../../utils/global_variables.dart';

class CustomFavoriteContainer extends StatelessWidget {
  const CustomFavoriteContainer({Key? key, required this.notif}) : super(key: key);

  final List<model.User> notif;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double paddingPosts = 0;
    if (size.width >= webScreenSize) {
      paddingPosts = 10;
    } else {
      paddingPosts = 15;
    }

    return Container(
      padding: EdgeInsets.only(top: paddingPosts),
      width: double.infinity,
      child: ListView.builder(
          itemCount: notif.length,
          itemBuilder: (BuildContext context,int index) {
            return GestureDetector(
              child: CustomFavoriteElement(notif: notif[index]),
            );
          },
      ),
    );
  }
}
