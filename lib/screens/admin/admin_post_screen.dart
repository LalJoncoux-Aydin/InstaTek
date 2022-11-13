import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:instatek/methods/firestore_methods.dart';
import 'package:instatek/models/post.dart';
import 'package:instatek/widgets/tools/custom_loading_screen.dart';

class AdminPostScreen extends StatefulWidget {
  const AdminPostScreen({Key? key}) : super(key: key);

  @override
  State<AdminPostScreen> createState() => _AdminPostScreenState();
}

class _AdminPostScreenState extends State<AdminPostScreen> {
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
    if (_isLoading == false) {
      return const CustomLoadingScreen();
    } else {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (BuildContext ctx, int index) => Center(
                child: SizedBox(
                  width: 800,
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(postList[index].postUrl),
                      ),
                      title: Text(postList[index].username),
                      subtitle: Text(
                        'Description: ${postList[index].description}\nDate: ${postList[index].datePublished}\nUID: ${postList[index].uid}\npostId: ${postList[index].postId}',
                      ),
                      trailing: PopupMenuButton<String>(
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'delete',
                              child: Text(
                                'Delete ${postList[index].username} post',
                              ),
                            ),
                          ];
                        },
                        onSelected: (String value) {
                          if (value == 'delete') {
                            deletePost(postList[index]);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: postList.length,
            ),
          ),
        ),
      );
    }
  }

  void deletePost(Post postToDelete) async {
    print("?? que pasa");
    setState(() {
      _isLoading = false;
    });
    final String res = await FireStoreMethods().deletePost(postToDelete.postId);
    print(res);
    if (res == "success") {
      setupPosts();
    }
    setState(() {
      _isLoading = true;
    });
  }
}
