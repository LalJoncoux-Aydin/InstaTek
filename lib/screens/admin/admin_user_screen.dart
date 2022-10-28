import 'package:flutter/cupertino.dart';

class AdminUserScreen extends StatefulWidget {
  const AdminUserScreen({Key? key}) : super(key: key);

  @override
  State<AdminUserScreen> createState() => _AdminUserScreenState();
}

class _AdminUserScreenState extends State<AdminUserScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text("User");
  }
}
