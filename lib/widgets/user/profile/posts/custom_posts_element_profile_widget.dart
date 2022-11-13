import 'package:flutter/cupertino.dart';

import '../../../../models/post.dart';

class CustomPostsElementProfile extends StatelessWidget {
  const CustomPostsElementProfile({Key? key, required this.displayPost, required this.borderColor}) : super(key: key);

  final Post displayPost;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
      ),
      child: Image.network(displayPost.postUrl.toString()),
    );
  }
}
