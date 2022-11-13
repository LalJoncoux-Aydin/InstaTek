import 'package:flutter/material.dart';
import 'package:instatek/methods/auth_methods.dart';
import 'package:instatek/models/user.dart' as model;
import 'package:instatek/screens/user/profile/profile_screen.dart';
import 'package:instatek/widgets/tools/custom_text_form_field_widget.dart';

import '../../../utils/global_variables.dart';
import '../../../widgets/user/search/custom_profile_container_search_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late String searchStr = "Search for a user...";
  final TextEditingController _searchController = TextEditingController();
  bool typing = false;
  List<model.User> listResearch = <model.User>[];

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setupListUser();
    }
  }

  void setupListUser() async {
    final List<model.User>? userListTmp = await AuthMethods().getUserListByUsername(searchStr);
    if (userListTmp != null) {
      setState(() {
        listResearch = userListTmp;
      });
    }
  }

  @override
  void setState(dynamic fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double paddingHorizontal = 0;
    double paddingVertical = 0;

    if (size.width >= webScreenSize) {
      paddingHorizontal = 50;
      paddingVertical = 40;
    } else {
      paddingHorizontal = 20;
      paddingVertical = 20;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: size.width > webScreenSize ? null : AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        automaticallyImplyLeading: false,
        title: const Text("Research"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              CustomTextFormField(
                hintText: "Search for a user",
                textEditingController: _searchController,
                isPass: false,
                isValid: null,
                updateInput: updateSearch,
              ),
              const Divider(),
              CustomProfileContainerSearch(listResearch: listResearch, navigateToProfile: navigateToProfile),
            ],
          ),
        ),
      ),
    );
  }

  void updateSearch(dynamic newSearch) {
    setState(() {
      searchStr = newSearch;
    });
    setupListUser();
  }

  void navigateToProfile(dynamic uid) {
    Navigator.of(context).push(MaterialPageRoute<dynamic>(builder: (BuildContext context) => ProfileScreen(uid: uid)));
  }
}
