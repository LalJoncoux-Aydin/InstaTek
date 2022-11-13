import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instatek/methods/firestore_methods.dart';
import 'package:instatek/models/post.dart';
import 'package:instatek/utils/global_variables.dart';
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
    print(postListTmp);
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
              itemBuilder: (BuildContext ctx, int index) => Container(
                child: Text(postList[index].username),
              ),
              itemCount: postList.length,
            ),
          ),
        ),
      );
    }
  }
}
/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instatek/methods/firestore_methods.dart';
import 'package:instatek/models/post.dart';
import 'package:instatek/utils/global_variables.dart';
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
     final Size size = MediaQuery.of(context).size;
    double paddingGlobalHorizontal = 0;
    double paddingGlobalVertical = 0;

    if (size.width >= webScreenSize) {
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: paddingGlobalVertical, horizontal: paddingGlobalHorizontal),
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (BuildContext ctx, int index) => Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width > webScreenSize ? size.width * 0.3 : 0,
                    vertical: size.width > webScreenSize ? 10 : 0,
                  ),
                  child: 
                  Text(postList[index].description),
                  /*PostCard(
                    post: postList[index],
                  ),*/
                ),
                itemCount: postList.length,
              ),
            ),
          ),
        ),
      );
    }
        /* shrinkWrap: true,
      
            Center(
                child: SizedBox(
                  width: 800,
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage('${postListTmp['postUrl']}'),
                      ),
                      title: Text('${postListTmp['username']}'),
                      subtitle: Text(
                        'Description: ${postListTmp['description']}\nDate: ${postListTmp['datePublished'].toDate()}\nUID: ${postListTmp['uid']}\npostId: ${postListTmp['postId']}',
                      ),
                      trailing: PopupMenuButton<String>(
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'delete',
                              child: Text('Delete ${postListTmp['username']} post'),
                            ),
                          ];
                        },
                        onSelected: (String value) {
                          if (value == 'delete') {
                            FirebaseFirestore.instance
                                .collection('posts')
                                .doc(postListTmp['postId'])
                                .delete();
                          }
                          //print(data['uid']);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
          })
          .toList()
          .cast(),
          
              return Scaffold(
        body: Container(
      child: ListView.builder(
        itemBuilder: (BuildContext ctx, int index) => Container(
          child: SizedBox(
            width: 800,
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage('${postList[index].postUrl}'),
                ),
                title: Text('${postList[index].username}'),
                subtitle: Text(
                  'Description: ${postList[index].description}\nDate: ${postList[index].datePublished}.toDate()}\nUID: ${postList[index].uid}\npostId: ${postList[index].postId}',
                ),
                trailing: PopupMenuButton<String>(
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'delete',
                        child:
                            Text('Delete ${postList[index].username} post'),
                      ),
                    ];
                  },
                  onSelected: (String value) {
                    if (value == 'delete') {
                      FirebaseFirestore.instance
                          .collection('posts')
                          .doc(postList[index].postId)
                          .delete();
                    }
                    //print(data['uid']);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    )
          
  }
}*/


*/
