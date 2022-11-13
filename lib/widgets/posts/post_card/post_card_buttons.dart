import 'package:flutter/material.dart';
import 'package:instatek/models/post.dart';
import 'package:instatek/models/user.dart' as model;
import 'package:instatek/screens/posts/feed/comments_screen.dart';
import 'package:instatek/widgets/posts/like_animation.dart';

class PostCardButtons extends StatelessWidget {
  const PostCardButtons({
    Key? key,
    required this.displayPost,
    required this.myUser,
    required this.isLiked,
    required this.onLiked,
  }) : super(key: key);

  final Post displayPost;
  final model.User myUser;
  final bool isLiked;
  final Function() onLiked;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        LikeAnimation(
          isAnimating: isLiked,
          smallLike: true,
          child: IconButton(
            icon: isLiked
                ? const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : Icon(
                    Icons.favorite_border,
                    color: Theme.of(context).iconTheme.color,
                  ),
            onPressed: () => onLiked(),
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
                postId: displayPost.postId,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
