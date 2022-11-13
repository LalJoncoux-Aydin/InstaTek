import 'package:flutter/material.dart';
import 'package:instatek/methods/firestore_methods.dart';
import 'package:instatek/models/post.dart';
import 'package:instatek/models/user.dart' as model;
import 'package:instatek/widgets/posts/like_animation.dart';

class PostCardImage extends StatelessWidget {
  const PostCardImage({
    Key? key,
    required this.displayPost,
    required this.myUser,
  }) : super(key: key);

  final Post displayPost;
  final model.User myUser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
/*        FireStoreMethods().addOrRemoveLikeOnPost(
          displayPost.postId,
          myUser.uid,
          displayPost.likes,
        );*/
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
        ],
      ),
/*          AnimatedOpacity(
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
      ),*/
    );
  }
}
