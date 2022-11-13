import 'package:flutter/material.dart';
import 'package:instatek/methods/firestore_methods.dart';
import 'package:instatek/models/post.dart';
import 'package:instatek/models/user.dart';
import 'package:instatek/widgets/posts/like_animation.dart';

class PostCardImage extends StatelessWidget {
  const PostCardImage({
    Key? key,
    required this.post,
    required this.user,
    required this.isLikeAnimating,
    required this.setIsLikeAnimating,
  }) : super(key: key);

  final Post post;
  final User user;
  final bool isLikeAnimating;
  final Function setIsLikeAnimating;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        FireStoreMethods().addOrRemoveLikeOnPost(
          post.postId.toString(),
          user.uid,
          post.likes,
        );
        setIsLikeAnimating(true);
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              post.postUrl.toString(),
              fit: BoxFit.cover,
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isLikeAnimating ? 1 : 0,
            child: LikeAnimation(
              isAnimating: isLikeAnimating,
              duration: const Duration(
                milliseconds: 400,
              ),
              onEnd: () {
                setIsLikeAnimating(false);
              },
              child: post.likes.contains(user.uid)
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 100,
                    )
                  : Icon(
                      Icons.favorite,
                      color: Theme.of(context).primaryColor,
                      size: 100,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
