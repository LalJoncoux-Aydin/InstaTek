import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class CustomPostsContainerProfile extends StatelessWidget {
  const CustomPostsContainerProfile({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    double correctRatio = MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.7);
    final Size size = MediaQuery.of(context).size;
    double paddingPosts = 0;
    if (size.width >= 1366) {
      paddingPosts = 10;
    } else {
      paddingPosts = 15;
    }

    return Container(
      padding: EdgeInsets.only(top: paddingPosts),
      width: double.infinity,
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('posts').where('uid', isEqualTo: uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = snapshot.data!.docs;
          docs.sort((QueryDocumentSnapshot<Map<String, dynamic>> a, QueryDocumentSnapshot<Map<String, dynamic>> b) => a.data()['datePublished'].toDate().toString().compareTo(b.data()['datePublished'].toDate().toString()));
          docs = docs.reversed.toList();

          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: correctRatio,
            ),
            itemCount: docs.length,
            itemBuilder: (BuildContext ctx, int index) => Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: whiteColor),
                  ),
                  child: Image.network(docs[index].data()['postUrl'].toString()),
            ),
          );
        },
      ),
    );
  }
}
