import 'package:flutter/material.dart';
import 'package:instatek/models/post.dart';
import 'package:instatek/models/user.dart';
import 'package:instatek/screens/posts/feed/comments_screen.dart';
import 'package:intl/intl.dart';

class PostCardFooter extends StatelessWidget {
  const PostCardFooter({
    Key? key,
    required this.displayPost,
    required this.myUser,
    required this.numberOfComments,
    required this.numberOfLikes,
  }) : super(key: key);

  final Post displayPost;
  final User myUser;
  final int numberOfComments;
  final int numberOfLikes;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$numberOfLikes likes',
            style: Theme.of(context).textTheme.headline1,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 8),
            child: RichText(
              text: TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: displayPost.username,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  TextSpan(
                    text: ' ${displayPost.description}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                'View all $numberOfComments comments',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => CommentsScreen(
                  postId: displayPost.postId,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              DateFormat.yMMMd().format(displayPost.datePublished),
              style: Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: Theme.of(context).textTheme.caption!.fontSize! - 2,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
