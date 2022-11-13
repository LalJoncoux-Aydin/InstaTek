import 'package:flutter/material.dart';
import '../../../../models/post.dart';
import '../../../../utils/colors.dart';

class CustomPostsContainerProfile extends StatelessWidget {
  const CustomPostsContainerProfile({Key? key, required this.listPost}) : super(key: key);

  final List<Post> listPost;

  @override
  Widget build(BuildContext context) {
    final double correctRatio = MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.7);
    final Size size = MediaQuery.of(context).size;
    double paddingHorizontal = 0;
    double paddingVertical = 0;
    if (size.width >= 1366) {
      paddingHorizontal = 20;
      paddingVertical = 0;
    } else {
      paddingHorizontal = 20;
      paddingVertical = 0;
    }

    return Container(
      padding: EdgeInsets.only(top: paddingVertical, left: paddingHorizontal, right: paddingHorizontal),
      width: double.infinity,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: correctRatio,
        ),
        itemCount: listPost.length,
        itemBuilder: (BuildContext ctx, int index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: whiteColor),
              ),
              child: Image.network(listPost[index].postUrl.toString()),
        ),
      ),
    );
  }
}
