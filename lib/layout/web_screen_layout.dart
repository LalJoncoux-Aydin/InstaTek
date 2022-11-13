import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instatek/screens/user/favorite/favorite_screen.dart';
import 'package:instatek/utils/colors.dart';

import '../custom_icons.dart';
import '../screens/posts/addpost/add_post_screen.dart';
import '../screens/posts/feed/feed_screen.dart';
import '../screens/user/profile/profile_screen.dart';
import '../screens/user/search/search_screen.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  double groupAligment = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
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
                icon: Icon(Icons.home_outlined, color: Theme.of(context).iconTheme.color),
                selectedIcon: Icon(Icons.home, color: Theme.of(context).iconTheme.color!.withOpacity(1.0)),
                label: Text('Home', style: Theme.of(context).textTheme.headline1),
              ),
              NavigationRailDestination(
                icon: Icon(CustomIcons.search_outline, color: Theme.of(context).iconTheme.color, size: 20,),
                selectedIcon: Icon(CustomIcons.search, color: Theme.of(context).iconTheme.color!.withOpacity(1.0), size: 20),
                label: Text('Search', style: Theme.of(context).textTheme.headline1),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add_box_outlined, color: Theme.of(context).iconTheme.color),
                selectedIcon: Icon(Icons.add_box, color: Theme.of(context).iconTheme.color!.withOpacity(1.0)),
                label: Text('Search', style: Theme.of(context).textTheme.headline1),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.favorite_outline, color: Theme.of(context).iconTheme.color),
                selectedIcon: Icon(Icons.favorite, color: Theme.of(context).iconTheme.color!.withOpacity(1.0)),
                label: Text('Favorite', style: Theme.of(context).textTheme.headline1),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person_outline, color: Theme.of(context).iconTheme.color),
                selectedIcon: Icon(Icons.person, color: Theme.of(context).iconTheme.color!.withOpacity(1.0)),
                label: Text('Person', style: Theme.of(context).textTheme.headline1),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // Text('selectedIndex: $_selectedIndex'),
          if (_selectedIndex == 0)
            const Expanded(
              child: FeedScreen(),
            ),

          if (_selectedIndex == 1)
            const Expanded(
                child: SearchScreen(),
            ),
          if (_selectedIndex == 2)
            const Expanded(
                child: AddPostScreen(),
            ),
          if (_selectedIndex == 3)
            const Expanded(
                child: FavoriteScreen(),
            ),
          if (_selectedIndex == 4)
            const Expanded(
              child: ProfileScreen(),
            ),
        ],
      ),
    );
  }
}

