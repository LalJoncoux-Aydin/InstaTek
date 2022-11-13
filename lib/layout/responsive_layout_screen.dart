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
  bool isAdmin = false;
  bool _isLoading = false;

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
    userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
    if (userProvider.isUser == true) {
      setState(() {
        myUser = userProvider.getUser;
        isAdmin = myUser.isAdmin;
        _isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    if (_isLoading == false) {
      return const CustomLoadingScreen();
    } else {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (size.width > webScreenSize && isAdmin == false) {
            return widget.webScreenLayout;
          } else if (size.width > webScreenSize && isAdmin == true) {
            return widget.adminScreenLayout;
          } else {
            return widget.mobileScreenLayout;
          }
        },
      );
    }
  }
}