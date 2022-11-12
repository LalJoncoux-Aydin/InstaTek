import 'package:flutter/material.dart';
import 'package:instatek/models/user.dart' as model;
import 'package:instatek/providers/user_provider.dart';
import 'package:instatek/utils/global_variables.dart';
import 'package:provider/provider.dart';

import '../widgets/tools/custom_loading_screen.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({Key? key, required this.webScreenLayout, required this.mobileScreenLayout, required this.adminScreenLayout}) : super(key:key);
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  final Widget adminScreenLayout;

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> with SingleTickerProviderStateMixin {
  late UserProvider userProvider;
  late model.User myUser;
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
        _isLoading = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading == false) {
      return const CustomLoadingScreen();
    } else {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > webScreenSize && myUser.isAdmin == false) {
            return widget.webScreenLayout;
          } else
          if (constraints.maxWidth > webScreenSize && myUser.isAdmin == true) {
            return widget.adminScreenLayout;
          }
          return widget.mobileScreenLayout;
        },
      );
    }
  }
}