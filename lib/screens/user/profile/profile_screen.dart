import 'package:flutter/material.dart';
import 'package:instatek/methods/auth_methods.dart';
import 'package:instatek/methods/firestore_methods.dart';
import 'package:instatek/models/user.dart' as model;
import 'package:instatek/widgets/tools/custom_loading_screen.dart';
import 'package:instatek/widgets/user/profile/button/custom_button_profile_widget.dart';
import 'package:instatek/widgets/user/profile/infobar/custom_infobar_profile_widget.dart';
import 'package:provider/provider.dart';
import '../../../models/post.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/global_variables.dart';
import '../../../widgets/user/profile/posts/custom_posts_container_profile_widget.dart';
import '../../auth/login_screen.dart';
import 'modify_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, this.uid = ""}) : super(key: key);
  final String uid;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProvider userProvider;
  late model.User? myUser;
  late String userUid = "";
  late String ownerUid = "";
  late String username = "";
  late List<dynamic> followers = <dynamic>[];
  late List<dynamic> following = <dynamic>[];
  late List<Post> postList = <Post>[];
  late int postSize = 0;
  late String photoUrl;
  late String bio;
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late GlobalKey<FormState> formKeyFollow = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isLoadingFollow = false;
  late bool _isFollowed = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setupUser();
    }
  }

  @override
  void setState(dynamic fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  void setupUser() async {
    // Get actual user
    userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
    if (userProvider.isUser == true) {
      setState(() {
        ownerUid = userProvider.getUser.uid;
      });
    }

    // Get user for own profile or others profile
    if (widget.uid != "") {
      myUser = (await AuthMethods().getSpecificUserDetails(widget.uid))!;
      setState(() {
        userUid = myUser!.uid;
      });

    } else {
      if (userProvider.isUser == true) {
        setState(() {
          myUser = userProvider.getUser;
          _isFollowed = false;
        });
      }
    }
    setState(() {
      username = myUser!.username;
      followers = myUser!.followers;
      following = myUser!.following;
      photoUrl = myUser!.avatarUrl;
      bio = myUser!.bio;
      _isLoading = true;
      _isFollowed = false;
    });

    if (userUid != "") {
      for (dynamic f in followers) {
        if (f == ownerUid) {
          setState(() {
            _isFollowed = true;
          });
        }
      }
    }

    if (myUser != null) {
      final List<Post>? postListTmp = await FireStoreMethods().getUserPosts(myUser!.uid,);
      if (postListTmp != null) {
        setState(() {
          postList = postListTmp;
          postSize = postList.length;
        });
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
    double paddingHorizontal = 0;
    double paddingVertical = 0;

    if (size.width >= webScreenSize) {
      paddingHorizontal = 70;
      paddingVertical = 40;
    } else {
      paddingHorizontal = 0;
      paddingVertical = 20;
    }

    if (_isLoading == false) {
      return const CustomLoadingScreen();
    } else {
      return Scaffold(
        appBar: size.width > webScreenSize ? null : AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(
            username,
          ),
          automaticallyImplyLeading: userUid != "",
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () async {
                await AuthMethods().signOut();
                if (!mounted) return;
                await Navigator.of(context).pushReplacement(
                  MaterialPageRoute<dynamic>(builder: (BuildContext context) => const LoginScreen(),),
                );
              },
            ),
          ],
          centerTitle: false,
        ),
        body: SafeArea(
          child: Form(
            key: userUid == "" ? formKey : formKeyFollow,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical) ,
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    CustomInfobarProfile(photoUrl: photoUrl, followers: followers.length, following: following.length, postSize: postSize, username: username, bio: bio),
                    CustomButtonProfile(userUid: userUid, isFollowed: _isFollowed, modifyAccount: modifyAccount, addFollowers: addFollowers, removeFollowers: removeFollowers, theme: Theme.of(context).colorScheme.tertiary, isLoadingFollow: _isLoadingFollow, formKey: formKey, formKeyFollow: formKeyFollow),
                    CustomPostsContainerProfile(listPost: postList, borderColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3)),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  void modifyAccount(dynamic formKey, BuildContext? context) async {
    await Navigator.of(context!).push(
        MaterialPageRoute<dynamic>(builder: (BuildContext context) => const ModifyProfile(),),
    );
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
      if (res == "success") {
        setupUser();
      }
      setState(() {
        _isLoadingFollow = false;
      });
    }
  }
}