import 'package:flutter/cupertino.dart';

class AdminHistoryScreen extends StatefulWidget {
  const AdminHistoryScreen({Key? key}) : super(key: key);

  @override
  State<AdminHistoryScreen> createState() => _AdminHistoryScreenState();
}

class _AdminHistoryScreenState extends State<AdminHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("History"),
    );
  }
}
