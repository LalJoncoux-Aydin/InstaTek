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
import 'modify_button_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, this.uid = ""}) : super(key: key);
  final String uid;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProvider userProvider;
  late model.User myUser;
  late String userUid = "";
  late String ownerUid = "";
  late String username = "";
  late List<dynamic> followers;
  late List<dynamic> following;
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
        userUid = myUser.uid;
      });
    } else {
      if (userProvider.isUser == true) {
        setState(() {
          myUser = userProvider.getUser;
        });
      }
    }

    setState(() {
      username = myUser.username;
      followers = myUser.followers;
      following = myUser.following;
      photoUrl = myUser.avatarUrl;
      bio = myUser.bio;
      _isLoading = true;
      _isFollowed = false;
    });
    final QuerySnapshot<Map<String, dynamic>> postSnap = await FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: widget.uid)
        .get();
    setState(() {
      postSize = postSnap.docs.length;
    });

    if (userUid != "") {
      for (dynamic f in following) {
        if (f == ownerUid) {
          setState(() {
            _isFollowed = true;
          });
        }
      }
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
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: paddingGlobalHorizontal, vertical: paddingGlobalVertical),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    CustomInfobarProfile(photoUrl: photoUrl, followers: followers.length, following: following.length, postSize: postSize, username: username, bio: bio),
                    if (userUid == "") const ModifyButtonProfile() else if (_isFollowed == false) CustomValidationButton(displayText: "Follow", formKey: formKey, loadingState: _isLoadingFollow, onTapFunction: addFollowers, shapeDecoration: null) else if (_isFollowed == true) CustomValidationButton(displayText: "Unfollow", formKey: formKey, loadingState: _isLoadingFollow, onTapFunction: removeFollowers, shapeDecoration: null),
                    CustomPostsContainerProfile(uid: widget.uid),
                  ],
                ),
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
        userUid: widget.uid,
        ownerUid: ownerUid,
      );
      if (res == "success") {
        setupUser();
      }
      setState(() {
        _isLoadingFollow = false;
      });
    }
  }

  void removeFollowers(dynamic formKey, BuildContext? context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoadingFollow = true;
      });
      final String res = await AuthMethods().removeFollowers(
        userUid: widget.uid,
        ownerUid: ownerUid,
      );
      print(res);
      if (res == "success") {
        setupUser();
      }
      setState(() {
        _isLoadingFollow = false;
      });
    }
  }
}