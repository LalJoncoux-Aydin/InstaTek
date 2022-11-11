import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class CustomProfileContainerSearch extends StatelessWidget {
  const CustomProfileContainerSearch({Key? key, required this.username, required this.navigateToProfile}) : super(key: key);

  final String username;
  final void Function(String) navigateToProfile;

  @override
  Widget build(BuildContext context) {
    final double correctRatio = MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.4);
    final Size size = MediaQuery.of(context).size;
    double paddingPosts = 0;
    double paddingGlobal = 0;
    if (size.width >= 1366) {
      paddingPosts = 10;
      paddingGlobal = 10;
    } else {
      paddingPosts = 15;
      paddingGlobal = 10;
    }

    return Container(
      padding: EdgeInsets.only(top: paddingPosts),
      width: double.infinity,
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('users').where('username', isEqualTo: username).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = snapshot
              .data!.docs;
          docs = docs.reversed.toList();

          if (docs.isEmpty) {
            return const Text("No result");
          } else {
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: correctRatio,
              ),
              itemCount: docs.length,
              itemBuilder: (BuildContext ctx, int index) =>
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: whiteColor),
                  ),
                  child:
                    Container(
                    padding: EdgeInsets.symmetric(horizontal: paddingGlobal),
                    width: double.infinity,
                      child: GestureDetector(
                        onTap: () {
                          navigateToProfile(docs[index].data()['uid'].toString());
                        },
                        child: Column(
                          children: <Widget>[
                            Image.network(docs[index].data()['avatarUrl'].toString()),
                            Text(docs[index].data()['username'].toString())
                          ],
                        ),
                      ),
                    ),
                ),
            );
          }
        },
      ),
    );
  }


}
