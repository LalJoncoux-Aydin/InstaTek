import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instatek/models/user.dart' as model;
import 'package:instatek/utils/colors.dart';
import 'package:instatek/widgets/tools/custom_loading_screen.dart';
import 'package:instatek/widgets/user/profile/infobar/custom_infobar_profile_widget.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/user/profile/posts/custom_posts_container_profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProvider userProvider;
  late model.User myUser;
  late String username = "";
  late int followers = 0;
  late int following = 0;
  late int postSize = 0;
  late String photoUrl;
  late String bio;
  late String uid = "";
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setupUser();
  }

  void setupUser() async {
    userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
    if (userProvider.isUser == true) {
      setState(() {
        myUser = userProvider.getUser;
        username = myUser.username;
        followers = myUser.followers.length;
        following = myUser.following.length;
        photoUrl = myUser.avatarUrl;
        bio = myUser.bio;
        uid = myUser.uid;
        _isLoading = true;
      });
    }
    if (uid != "") {
      final QuerySnapshot<Map<String, dynamic>> postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: uid)
          .get();
      setState(() {
        postSize = postSnap.docs.length;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double paddingGlobal = 0;
    if (size.width >= 1366) {
      paddingGlobal = 500;
    } else {
      paddingGlobal = 60;
    }

    if (_isLoading == false) {
      setupUser();
      return const CustomLoadingScreen();
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: Text(
            username,
          ),
          centerTitle: false,
        ),
        body: SafeArea(
          child: Column(children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: paddingGlobal),
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      CustomInfobarProfile(photoUrl: photoUrl, followers: followers, following: following, postSize: postSize, username: username, bio: bio, formKey: formKey),
                      const Divider(),
                      CustomPostsContainerProfile(uid: uid),
                    ],
                  ),
                ),
              ),
            ),
          ],),
        ),
      );
    }
  }
}