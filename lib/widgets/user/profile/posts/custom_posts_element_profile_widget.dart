import 'package:flutter/material.dart';

import '../../../../models/post.dart';

class CustomPostsElementProfile extends StatelessWidget {
  const CustomPostsElementProfile({Key? key, required this.displayPost}) : super(key: key);

  final Post displayPost;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.3)),
      ),
      child: Image.network(displayPost.postUrl.toString()),
    );
  }
}
