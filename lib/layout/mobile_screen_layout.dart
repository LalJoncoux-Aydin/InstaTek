import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instatek/custom_icons.dart';
import 'package:instatek/utils/global_variables.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _currentPage = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
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
      _currentPage = page;
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
        currentIndex: _currentPage,
        backgroundColor: Theme.of(context).colorScheme.background,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Icon(
                (_currentPage == 0) ? Icons.home : Icons.home_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            label: '',
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          BottomNavigationBarItem(
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: Icon(
                CustomIcons.search,
                color: Theme.of(context).iconTheme.color,
                size: 24,
              ),
            ),
            icon: Container(
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: Center(
                child: Icon(
                  CustomIcons.search_outline,
                  color: Theme.of(context).iconTheme.color,
                  size: 24,
                ),
              ),
            ),
            label: '',
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          BottomNavigationBarItem(
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Icon(
                Icons.add_box,
                color: Theme.of(context).iconTheme.color,
                size: 26,
              ),
            ),
            icon: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Icon(
                Icons.add_box_outlined,
                color: Theme.of(context).iconTheme.color,
                size: 26,
              ),
            ),
            label: '',
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          BottomNavigationBarItem(
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Icon(
                Icons.favorite,
                color: Theme.of(context).iconTheme.color,
                size: 26,
              ),
            ),
            icon: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Icon(
                Icons.favorite_outline,
                color: Theme.of(context).iconTheme.color,
                size: 26,
              ),
            ),
            label: '',
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          BottomNavigationBarItem(
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Icon(
                Icons.person,
                color: Theme.of(context).iconTheme.color,
                size: 26,
              ),
            ),
            icon: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Icon(
                Icons.person_outline,
                color: Theme.of(context).iconTheme.color,
                size: 26,
              ),
            ),
            label: '',
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
