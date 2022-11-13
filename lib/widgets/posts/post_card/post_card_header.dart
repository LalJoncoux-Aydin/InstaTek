import 'package:flutter/material.dart';
import 'package:instatek/models/post.dart';
import 'package:instatek/models/user.dart' as model;

class PostCardHeader extends StatelessWidget {
  const PostCardHeader({Key? key, required this.deletePost, required this.displayPost, required this.myUser}) : super(key: key);

  final void Function(String postId) deletePost;
  final Post displayPost;
  final model.User myUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ).copyWith(right: 0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(
              displayPost.avatarUrl,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              displayPost.username.toString(),
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          if (displayPost.uid == myUser.uid)
            IconButton(
              onPressed: () {
                showDialog(
                  useRootNavigator: false,
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shrinkWrap: true,
                        children: <String>[
                          'Delete',
                        ]
                            .map(
                              (String e) => InkWell(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                  child: Text(
                                    e,
                                    style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
                                  ),
                                ),
                                onTap: () {
                                  deletePost(displayPost.postId);
                                  Navigator.of(context).pop();
                                },
                              ),
                            )
                            .toList(),
                      ),
                    );
                  },
                );
              },
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).colorScheme.secondary,
              ),
            )
        ],
      ),
    );
  }
}
