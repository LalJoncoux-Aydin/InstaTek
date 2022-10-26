import 'package:flutter/material.dart';
import 'package:instatek/providers/user_provider.dart';
import 'package:instatek/utils/global_variables.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();
    addData();
  }

  void addData() async {
    userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > webScreenSize && userProvider.getUser.isAdmin == false) {
          return widget.webScreenLayout;
        } else if (constraints.maxWidth > webScreenSize && userProvider.getUser.isAdmin == true) {
          return widget.adminScreenLayout;
        }
        return widget.mobileScreenLayout;
      },
    );
  }
}