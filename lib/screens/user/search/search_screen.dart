import 'package:flutter/material.dart';
import 'package:instatek/screens/user/profile/profile_screen.dart';
import 'package:instatek/utils/colors.dart';
import 'package:instatek/widgets/tools/custom_text_form_field_widget.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double paddingGlobalHorizontal = 0;
    double paddingGlobalVertical = 0;

    if (size.width >= 1366) {
      paddingGlobalHorizontal = 50;
      paddingGlobalVertical = 40;
    } else {
      paddingGlobalHorizontal = 0;
      paddingGlobalVertical = 20;
    }

    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: CustomTextFormField(
          hintText: "Search for a user",
          textEditingController: _searchController,
          isPass: false,
          isValid: null,
          updateInput: updateSearch,
        ),
        actions: const <Widget>[
          Icon(
            Icons.search,
            color: whiteColor,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: paddingGlobalHorizontal, vertical: paddingGlobalVertical),
            width: double.infinity,
            child: CustomProfileContainerSearch(username: searchStr, navigateToProfile: navigateToProfile),
          ),
        ),
      ),
    );
  }

  void updateSearch(dynamic newSearch) {
    setState(() {
      searchStr = newSearch;
    });
  }

  void navigateToProfile(dynamic uid) {
    Navigator.of(context).push(MaterialPageRoute<dynamic>(builder: (BuildContext context) => ProfileScreen(uid: uid)));
  }
}
