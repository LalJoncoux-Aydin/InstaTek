import 'package:flutter/material.dart';
import 'package:instatek/models/user.dart' as model;
import 'package:instatek/utils/colors.dart';
import 'package:instatek/widgets/custom_loading_screen.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/custom_header_profile_widget.dart';
import '../widgets/custom_name_container_profile_widget.dart';

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
  late String photoUrl;
  late String bio;
  bool isLoading = false;

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
        photoUrl = myUser.photoUrl;
        bio = myUser.bio;
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

    return isLoading ? const CustomLoadingScreen() : Scaffold(
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
                    CustomHeaderProfile(
                      photoUrl: photoUrl,
                      followers: followers,
                      following: following,
                    ),
                    CustomNameContainerProfile(
                      username: username,
                      bio: bio,
                    ),
                    const Divider(),
                    // TODO : posts
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