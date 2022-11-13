import 'package:flutter/material.dart';
import 'package:instatek/models/user.dart' as model;
import '../../../methods/firestore_methods.dart';
import '../../../models/post.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/utils.dart';
import '../../../widgets/posts/post_card/post_card_buttons.dart';
import '../../../widgets/posts/post_card/post_card_footer.dart';
import '../../../widgets/posts/post_card/post_card_header.dart';
import '../../../widgets/posts/post_card/post_card_image.dart';

class PostCard extends StatefulWidget {
  const PostCard({Key? key, required this.displayPost, required this.myUser}) : super(key: key);

  final Post displayPost;
  final model.User myUser;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int nbComment = 0;
  bool isLiked = false;
  int nbLikes = 0;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setupLiked();
    }
  }

  @override
  void setState(dynamic fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  void setupLiked() async {
    setState(() {
      isLiked = widget.displayPost.likes.contains(widget.myUser.uid);
      nbLikes = widget.displayPost.likes.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Container(
      margin: width > webScreenSize ? const EdgeInsets.symmetric(vertical: 10) : const EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
        border: Border.all(
          color: width > webScreenSize ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primary,
        ),
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primary,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: <Widget>[
          PostCardHeader(
            deletePost: deletePost,
            myUser: widget.myUser,
            displayPost: widget.displayPost,
          ),
          PostCardImage(
            myUser: widget.myUser,
            displayPost: widget.displayPost,
            isLiked: isLiked,
            onLiked: onLiked,
          ),
          PostCardButtons(
            myUser: widget.myUser,
            displayPost: widget.displayPost,
            isLiked: isLiked,
            onLiked: onLiked,
          ),
          PostCardFooter(
            myUser: widget.myUser,
            displayPost: widget.displayPost,
            numberOfComments: nbComment,
            numberOfLikes: nbLikes,
          )
        ],
      ),
    );
  }

  void onLiked() async {
    final String res = await FireStoreMethods().addOrRemoveLikeOnPost(
      widget.displayPost.postId,
      widget.myUser.uid,
      widget.displayPost.likes,
      isLiked,
    );
    if (res == 'add') {
      setState(() {
        isLiked = true;
        nbLikes += 1;
      });
    } else if (res == 'remove') {
      setState(() {
        isLiked = false;
        nbLikes -= 1;
      });
    }
  }

  void deletePost(String postId) async {
    try {
      await FireStoreMethods().deletePost(postId);
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void fetchNumberOfComments() async {
    try {
      final int nbCommentTmp = await FireStoreMethods().getPostCommentNb(widget.displayPost.uid);
      setState(() {
        nbComment = nbCommentTmp;
      });
    } catch (err) {
      if (mounted) {
        showSnackBar(context, err.toString());
      }
    }
  }
}
