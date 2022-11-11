import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instatek/methods/auth_methods.dart';
import 'package:instatek/models/user.dart' as model;
import 'package:instatek/utils/colors.dart';
import 'package:instatek/widgets/tools/custom_loading_screen.dart';
import 'package:instatek/widgets/tools/custom_validation_button.dart';
import 'package:instatek/widgets/user/profile/infobar/custom_infobar_profile_widget.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';
import '../../../widgets/user/profile/posts/custom_posts_container_profile_widget.dart';
import '../../auth/login_screen.dart';
import '../search/follow_button_profile_screen.dart';
import 'modify_button_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProvider userProvider;
  late model.User myUser;
  late String ownerUid;
  late String username = "";
  late int followers = 0;
  late int following = 0;
  late int postSize = 0;
  late String photoUrl;
  late String bio;
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isLoadingFollow = false;
  late bool _isFollowed = false;

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
        ownerUid = userProvider.getUser.uid;
      });
    }

    if (widget.uid != "") {
      myUser = (await AuthMethods().getSpecificUserDetails(widget.uid))!;
      setState(() {
        username = myUser.username;
        followers = myUser.followers.length;
        following = myUser.following.length;
        photoUrl = myUser.avatarUrl;
        bio = myUser.bio;
        _isLoading = true;
      });
      final QuerySnapshot<Map<String, dynamic>> postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
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
      setupUser();
      return const CustomLoadingScreen();
    } else {
      return Scaffold(
        backgroundColor: mobileBackgroundColor,
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: Text(
            username,
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: whiteColor,
              ),
              onPressed: () async {
                await AuthMethods().signOut();
                if (!mounted) return;
                await Navigator.of(context).pushReplacement(MaterialPageRoute<dynamic>(builder: (BuildContext context) => const LoginScreen(),),);
                },
            ),
          ],
          centerTitle: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: paddingGlobalHorizontal, vertical: paddingGlobalVertical),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  CustomInfobarProfile(photoUrl: photoUrl, followers: followers, following: following, postSize: postSize, username: username, bio: bio),
                  if (ownerUid == widget.uid) const ModifyButtonProfile() else if (_isFollowed == false) CustomValidationButton(displayText: "Follow", formKey: formKey, loadingState: _isLoadingFollow, onTapFunction: addFollowers, shapeDecoration: null) else if (_isFollowed == true) CustomValidationButton(displayText: "Unfo", formKey: formKey, loadingState: _isLoadingFollow, onTapFunction: addFollowers, shapeDecoration: null),
                  CustomPostsContainerProfile(uid: widget.uid),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  void addFollowers(dynamic formKey, BuildContext? context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoadingFollow = true;
      });
      final String res = await AuthMethods().addFollowers(
        uid: widget.uid,
      );
      _isFollowed = true;
      setState(() {
        _isLoadingFollow = false;
      });
    }
  }
}