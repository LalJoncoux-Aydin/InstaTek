import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:instatek/providers/user_provider.dart';
import 'package:instatek/resources/auth_methods.dart';
import 'package:provider/provider.dart';
import 'package:instatek/models/user.dart' as model;

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> with SingleTickerProviderStateMixin {
  String username = "";
  late UserProvider userProvider;

  @override
  void initState() {
    addData();
    super.initState();
  }

  addData() async {
    userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
    setState(() {
      username = userProvider.getUsername;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(username),
      ),
    );
  }
}

