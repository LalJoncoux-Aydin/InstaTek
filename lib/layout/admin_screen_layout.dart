import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instatek/screens/admin/admin_post_screen.dart';
import 'package:instatek/screens/admin/admin_user_screen.dart';
import 'package:instatek/utils/colors.dart';

class AdminScreenLayout extends StatefulWidget {
  const AdminScreenLayout({Key? key}) : super(key: key);

  @override
  State<AdminScreenLayout> createState() => AdminScreenLayoutState();
}

class AdminScreenLayoutState extends State<AdminScreenLayout> {
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  double groupAligment = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        centerTitle: true,
        title: SvgPicture.asset(
          'assets/instatek_logo.svg',
          color: primaryColor,
          height: 32,
        ),
      ),
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex,
            groupAlignment: groupAligment,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: labelType,
            destinations: <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.photo_library, color: Theme.of(context).iconTheme.color),
                selectedIcon:
                    Icon(Icons.photo_library_outlined, color: Theme.of(context).iconTheme.color!.withOpacity(1.0)),
                label: const Text('Posts'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person, color: Theme.of(context).iconTheme.color),
                selectedIcon: Icon(Icons.person_outline, color: Theme.of(context).iconTheme.color!.withOpacity(1.0)),
                label: const Text('Users'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          if (_selectedIndex == 0)
            const Expanded(
              child: AdminPostScreen(),
            ),
          if (_selectedIndex == 1)
            const Expanded(
              child: AdminUserScreen(),
            ),
        ],
      ),
    );
  }
}
