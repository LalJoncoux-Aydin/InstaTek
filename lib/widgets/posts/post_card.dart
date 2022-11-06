import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instatek/methods/firestore_methods.dart';
import 'package:instatek/models/user.dart' as model;
import 'package:instatek/providers/user_provider.dart';
import 'package:instatek/screens/comments_screen.dart';
import 'package:instatek/utils/colors.dart';
import 'package:instatek/utils/global_variables.dart';
import 'package:instatek/utils/utils.dart';
import 'package:instatek/widgets/posts/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);
  final dynamic snap;

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
      final QuerySnapshot<Object?> snap =
          await FirebaseFirestore.instance.collection('posts').doc(widget.snap['postId']).collection('comments').get();
      numberOfComments = snap.docs.length;
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
      // boundary needed for web
      decoration: BoxDecoration(
        border: Border.all(
          color: width > webScreenSize ? secondaryColor : Theme.of(context).primaryColor,
        ),
        color: Theme.of(context).primaryColor,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: <Widget>[
          // HEADER SECTION OF THE POST
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    widget.snap['avatarUrl'].toString(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.snap['username'].toString(),
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ),
                  ),
                ),
                if (widget.snap['uid'].toString() == user.uid)
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
                                        deletePost(
                                          widget.snap['postId'].toString(),
                                        );
                                        // remove the dialog box
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
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                else
                  Container(),
              ],
            ),
          ),
          // IMAGE SECTION OF THE POST
          GestureDetector(
            onDoubleTap: () {
              FireStoreMethods().addOrRemoveLikeOnPost(
                widget.snap['postId'].toString(),
                user.uid,
                widget.snap['likes'],
              );
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Image.network(
                    widget.snap['postUrl'].toString(),
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
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                    child: widget.snap['likes'].contains(user.uid)
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
          ),
          // LIKE, COMMENT SECTION OF THE POST
          Row(
            children: <Widget>[
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user.uid),
                smallLike: true,
                child: IconButton(
                  icon: widget.snap['likes'].contains(user.uid)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(
                          Icons.favorite_border,
                          color: Theme.of(context).iconTheme.color,
                        ),
                  onPressed: () => FireStoreMethods().addOrRemoveLikeOnPost(
                    widget.snap['postId'].toString(),
                    user.uid,
                    widget.snap['likes'],
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
                      postId: widget.snap['postId'].toString(),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.send_outlined,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {},
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.bookmark_border,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () {},
                  ),
                ),
              )
            ],
          ),
          //DESCRIPTION AND NUMBER OF COMMENTS
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${widget.snap['likes'].length} likes',
                  style: Theme.of(context).textTheme.headline1,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: widget.snap['username'].toString(),
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        TextSpan(
                          text: ' ${widget.snap['description']}',
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
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => CommentsScreen(
                        postId: widget.snap['postId'].toString(),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    DateFormat.yMMMd().format(widget.snap['datePublished'].toDate()),
                    style: Theme.of(context).textTheme.button!.copyWith(
                          fontSize: Theme.of(context).textTheme.caption!.fontSize! - 2,
                        ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
