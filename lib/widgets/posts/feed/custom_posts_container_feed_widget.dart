/*
import 'package:flutter/material.dart';
import '../../../../models/post.dart';
import '../../../../utils/colors.dart';
import '../../../screens/posts/feed/post_card.dart';

class CustomPostsContainerFeed extends StatelessWidget {
  const CustomPostsContainerFeed({Key? key, required this.listPost}) : super(key: key);

  final List<Post> listPost;

  @override
  Widget build(BuildContext context) {
    // final double correctRatio = MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.7);
    final Size size = MediaQuery.of(context).size;
    double paddingPosts = 0;
    if (size.width >= 1366) {
      paddingPosts = 10;
    } else {
      paddingPosts = 15;
    }

    return Container(
      padding: EdgeInsets.only(top: paddingPosts),
      width: double.infinity,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: listPost.length,
        itemBuilder: (BuildContext ctx, int index) => Container(
          decoration: BoxDecoration(
            border: Border.all(color: whiteColor),
          ),
          child: PostCard(
            displayPost: listPost[index],
            myUser: null,
          ),
        ),
      ),
    );
  }
}
*/
