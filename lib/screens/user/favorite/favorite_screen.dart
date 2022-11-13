import 'package:flutter/material.dart';
import 'package:instatek/methods/auth_methods.dart';
import 'package:instatek/models/user.dart' as model;
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../../../utils/global_variables.dart';
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
  late List<dynamic> notif;
  late List<model.User> notifDetail = <model.User>[];
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
        notif = myUser.notification;
        _isLoading = true;
      });
      for (dynamic n in notif) {
        final model.User nUser = (await AuthMethods().getSpecificUserDetails(n))!;
        setState(() {
          notifDetail.add(nUser);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double paddingGlobalHorizontal = 0;
    double paddingGlobalVertical = 0;

    if (size.width >= webScreenSize) {
      paddingGlobalHorizontal = 50;
      paddingGlobalVertical = 40;
    } else {
      paddingGlobalHorizontal = 0;
      paddingGlobalVertical = 20;
    }

    if (_isLoading == false) {
      return const CustomLoadingScreen();
    } else {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: size.width > webScreenSize ? null : AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const Text("Favorite"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: paddingGlobalHorizontal, vertical: paddingGlobalVertical),
              width: double.infinity,
              child: CustomFavoriteItem(notif : notifDetail),
          ),
        ),
      );
    }
  }
}
