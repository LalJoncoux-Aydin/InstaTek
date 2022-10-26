import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instatek/models/user.dart' as model;
import 'package:instatek/providers/user_provider.dart';
import 'package:instatek/utils/colors.dart';
import 'package:instatek/utils/global_variables.dart';
import 'package:provider/provider.dart';

class AdminScreenLayout extends StatefulWidget {
  const AdminScreenLayout({Key? key}) : super(key: key);

  @override
  State<AdminScreenLayout> createState() => AdminScreenLayoutState();
}

class AdminScreenLayoutState extends State<AdminScreenLayout> {
  String username = "";
  int _page = 0;
  late PageController pageController;
  late UserProvider userProvider;
  late model.User myUser;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    setupUser();
  }

  void setupUser() async {
    userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
    if (userProvider.isUser == true) {
      setState(() {
        myUser = userProvider.getUser;
        username = myUser.username;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: adminScreenItems,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.photo,
              color: (_page == 0) ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: (_page == 1) ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
              color: (_page == 2) ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,),
        ],
        onTap: navigationTapped,
        //currentIndex: _page,
      ),
    );
  }
}
