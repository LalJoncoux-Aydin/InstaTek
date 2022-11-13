import 'package:flutter/material.dart';
import 'package:instatek/methods/firestore_methods.dart';
import 'package:instatek/models/user.dart';
import 'package:instatek/widgets/tools/custom_loading_screen.dart';

class AdminUserScreen extends StatefulWidget {
  const AdminUserScreen({Key? key}) : super(key: key);

  @override
  State<AdminUserScreen> createState() => _AdminUserScreenState();
}

class _AdminUserScreenState extends State<AdminUserScreen> {
  late List<User?> userList = <User>[];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setupUsers();
    }
  }

  @override
  void setState(dynamic fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void setupUsers() async {
    final List<User?> userListTmp = await FireStoreMethods().getUsers();
    setState(() {
      userList = userListTmp;
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading == false) {
      return const CustomLoadingScreen();
    } else {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (BuildContext ctx, int index) => Center(
                child: SizedBox(
                  width: 800,
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(userList[index]!.avatarUrl),
                      ),
                      title: Text(userList[index]!.username),
                      subtitle: Text(
                        'Email: ${userList[index]!.email}\nBio: ${userList[index]!.bio}\nAdmin: ${userList[index]!.isAdmin}\nUID: ${userList[index]!.uid}',
                      ),
                      trailing: PopupMenuButton<String>(
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'delete',
                              child:
                                  Text('Delete ${userList[index]!.username}'),
                            ),
                          ];
                        },
                        onSelected: (String value) {
                          deleteUser(userList[index]!);
                        },
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: userList.length,
            ),
          ),
        ),
      );
    }
  }

  void deleteUser(User userToDelete) async {
    setState(() {
      _isLoading = false;
    });
    final String res = await FireStoreMethods().deleteUser(userToDelete.uid);
    if (res == "success") {
      setupUsers();
    }
    setState(() {
      _isLoading = true;
    });
  }
}
