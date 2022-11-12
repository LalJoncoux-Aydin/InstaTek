import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instatek/models/user.dart' as model;
import 'package:instatek/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../../../widgets/tools/custom_loading_screen.dart';
import '../../../widgets/user/favorite/custom_favorite_item_widget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late UserProvider userProvider;
  late model.User myUser;
  late List<dynamic> followers;
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
        followers = myUser.followers;
        _isLoading = true;
      });
    }
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
          title: const Text("Favorite"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: paddingGlobalHorizontal, vertical: paddingGlobalVertical),
              width: double.infinity,
              child: CustomFavoriteItem(followers : followers),
          ),
        ),
      );
    }
  }
}
