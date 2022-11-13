import 'package:flutter/material.dart';
import 'package:instatek/methods/firestore_methods.dart';
import 'package:instatek/models/post.dart';
import 'package:instatek/models/user.dart';
import 'package:instatek/screens/posts/feed/comments_screen.dart';
import 'package:instatek/widgets/posts/like_animation.dart';

class PostCardButtons extends StatelessWidget {
  const PostCardButtons({
    Key? key,
    required this.post,
    required this.user,
  }) : super(key: key);

  final Post post;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        LikeAnimation(
          isAnimating: post.likes.contains(user.uid),
          smallLike: true,
          child: IconButton(
            icon: post.likes.contains(user.uid)
                ? const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : Icon(
                    Icons.favorite_border,
                    color: Theme.of(context).iconTheme.color,
                  ),
            onPressed: () => FireStoreMethods().addOrRemoveLikeOnPost(
              post.postId.toString(),
              user.uid,
              post.likes,
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.comment_outlined,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => CommentsScreen(
                postId: post.postId.toString(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
