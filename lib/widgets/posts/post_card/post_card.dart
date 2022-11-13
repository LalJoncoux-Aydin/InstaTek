import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instatek/methods/firestore_methods.dart';
import 'package:instatek/models/user.dart' as model;
import 'package:instatek/providers/user_provider.dart';
import 'package:instatek/utils/colors.dart';
import 'package:instatek/utils/global_variables.dart';
import 'package:instatek/utils/utils.dart';
import 'package:instatek/widgets/posts/post_card_buttons.dart';
import 'package:instatek/widgets/posts/post_card_footer.dart';
import 'package:instatek/widgets/posts/post_card_header.dart';
import 'package:instatek/widgets/posts/post_card_image.dart';
import 'package:provider/provider.dart';

import '../../models/post.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int numberOfComments = 0;
  bool isLikeAnimating = false;

  @override
  void initState() {
    super.initState();
    fetchNumberOfComments();
  }

  void fetchNumberOfComments() async {
    try {
      final QuerySnapshot<Object?> post =
          await FirebaseFirestore.instance.collection('posts').doc(widget.post.postId).collection('comments').get();
      numberOfComments = post.docs.length;
    } catch (err) {
      if (mounted) {
        showSnackBar(context, err.toString());
      }
    }
    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    final double width = MediaQuery.of(context).size.width;

    return Container(
      margin:
          width > webScreenSize ? const EdgeInsets.symmetric(vertical: 10) : const EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
        border: Border.all(
          color: width > webScreenSize ? secondaryColor : Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: <Widget>[
          PostCardHeader(
            user: user,
            post: widget.post,
            deletePost: deletePost,
          ),
          PostCardImage(
            post: widget.post,
            user: user,
            isLikeAnimating: isLikeAnimating,
            setIsLikeAnimating: (bool value) {
              setState(() {
                isLikeAnimating = value;
              });
            },
          ),
          PostCardButtons(post: widget.post, user: user),
          PostCardFooter(post: widget.post, user: user, numberOfComments: numberOfComments),
        ],
      ),
    );
  }
}
