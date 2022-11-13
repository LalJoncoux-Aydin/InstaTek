import 'package:flutter/material.dart';
import 'package:instatek/utils/global_variables.dart';
import '../../../../models/post.dart';
import 'custom_posts_element_profile_widget.dart';

class CustomPostsContainerProfile extends StatelessWidget {
  const CustomPostsContainerProfile({Key? key, required this.listPost, required this.borderColor}) : super(key: key);

  final List<Post> listPost;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double paddingVertical = 0;
    double crossAxis = 0;
    double correctRatio = 0;
    if (size.width >= webScreenSize) {
      paddingVertical = 0;
      crossAxis = 600;
      correctRatio = MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height * 1.15);
    } else {
      paddingVertical = 20;
      crossAxis = 200;
      correctRatio = MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2.15);
    }

    if (listPost.isEmpty) {
     return const Text("No Post");
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
          itemCount: listPost.length,
          itemBuilder: (BuildContext ctx, int index) =>
              CustomPostsElementProfile(
                  displayPost: listPost[index], borderColor: borderColor),
        ),
      );
    }
  }
}
