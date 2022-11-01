import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminPostScreen extends StatefulWidget {
  const AdminPostScreen({Key? key}) : super(key: key);

  @override
  State<AdminPostScreen> createState() => _AdminPostScreenState();
}

class _AdminPostScreenState extends State<AdminPostScreen> {
  final Stream<QuerySnapshot<Object>> _usersStream =
      FirebaseFirestore.instance.collection('posts').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Object>>(
      stream: _usersStream,
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot<Object>> snapshot,
      ) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading');
        }

        return ListView(
          shrinkWrap: true,
          children: snapshot.data!.docs
              .map((DocumentSnapshot<Object> document) {
                final Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: SizedBox(
                      width: 800,
                      child: Card(
                        child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage('${data['postUrl']}'),
                            ),
                            title: Text('${data['username']}'),
                            subtitle: Text(
                                'Description: ${data['description']}\nDate: ${data['datePublished'].toDate()}\nUID: ${data['uid']}\npostId: ${data['postId']}'),
                            trailing: PopupMenuButton(
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    value: 'delete',
                                    child: Text('Delete ${data['username']}'),
                                  ),
                                ];
                              },
                              onSelected: (String value) {
                                //print(data['uid']);
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(data['uid'])
                                    .delete();
                              },
                            )),
                      ),
                    ),
                  ),
                );
              })
              .toList()
              .cast(),
          
        );
      },
    );
  }
}
