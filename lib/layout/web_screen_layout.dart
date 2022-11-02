import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instatek/models/user.dart' as model;
import 'package:instatek/providers/user_provider.dart';
import 'package:instatek/utils/colors.dart';
import 'package:instatek/utils/global_variables.dart';
import 'package:provider/provider.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> with SingleTickerProviderStateMixin {
  String username = "";
  int _page = 0;
  late PageController pageController;
  late UserProvider userProvider;
  late model.User myUser;

  @override
  void initState() {
    super.initState();
    setupUser();

    pageController = PageController();
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
        children: homeScreenItems,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Icon(
                Icons.home,
                color: (_page == 0) ? primaryColor : secondaryColor,
              ),
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Icon(
                Icons.search,
                color: (_page == 1) ? primaryColor : secondaryColor,
              ),
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Icon(
                Icons.add_circle,
                color: (_page == 2) ? primaryColor : secondaryColor,
              ),
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Icon(
                Icons.favorite,
                color: (_page == 3) ? primaryColor : secondaryColor,
              ),
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Icon(
                Icons.person,
                color: (_page == 4) ? primaryColor : secondaryColor,
              ),
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
        ],
        onTap: navigationTapped,
        //currentIndex: _page,
      ),
    );
  }
}

