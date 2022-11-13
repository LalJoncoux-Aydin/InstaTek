import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instatek/methods/firestore_methods.dart';
import 'package:instatek/models/post.dart';
import 'package:instatek/utils/global_variables.dart';
import 'package:instatek/widgets/posts/post_card.dart';
import 'package:instatek/widgets/tools/custom_loading_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late List<Post> postList = <Post>[];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setupPosts();
    }
  }

  @override
  void setState(dynamic fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void setupPosts() async {
    final List<Post> postListTmp = await FireStoreMethods().getFeedPosts();
    setState(() {
      postList = postListTmp;
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final Size size = MediaQuery.of(context).size;
    double paddingGlobalHorizontal = 0;
    double paddingGlobalVertical = 0;

    if (size.width >= 1366) {
      paddingGlobalHorizontal = 50;
      paddingGlobalVertical = 40;
    } else {
      paddingGlobalHorizontal = 0;
      paddingGlobalVertical = 20;
    }

    if (_isLoading == false) {
      return const CustomLoadingScreen();
    } else {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: width > webScreenSize
            ? null
            : AppBar(
                backgroundColor: Theme.of(context).colorScheme.background,
                centerTitle: false,
                title: SvgPicture.asset(
                  'assets/instatek_logo.svg',
                  color: Theme.of(context).colorScheme.secondary,
                  height: 32,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.messenger_outline_rounded,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: paddingGlobalVertical, horizontal: paddingGlobalHorizontal),
          child: ListView.builder(
            itemBuilder: (BuildContext ctx, int index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width > webScreenSize ? width * 0.3 : 0,
                vertical: width > webScreenSize ? 10 : 0,
              ),
              child: PostCard(
                post: postList[index],
              ),
            ),
            itemCount: postList.length,
          ),
        ),
      );
    }
  }
}
