import 'package:flutter/material.dart';
import 'package:instatek/models/post.dart';
import 'package:instatek/models/user.dart' as model;
import 'package:instatek/widgets/posts/like_animation.dart';

class PostCardImage extends StatelessWidget {
  const PostCardImage({
    Key? key,
    required this.displayPost,
    required this.myUser,
    required this.isLiked,
    required this.onLiked,
    required this.onStartAnimation,
    required this.onEndAnimation,
    required this.isAnimating,
  }) : super(key: key);

  final Post displayPost;
  final model.User myUser;
  final bool isLiked;
  final bool isAnimating;
  final Function() onLiked;
  final Function() onEndAnimation;
  final Function() onStartAnimation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        if (!isAnimating) {
          onStartAnimation();
          onLiked();
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              displayPost.postUrl,
              fit: BoxFit.cover,
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isAnimating ? 1 : 0,
            child: LikeAnimation(
              isAnimating: isAnimating,
              duration: const Duration(
                milliseconds: 400,
              ),
              onEnd: onEndAnimation,
              child: isLiked
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
