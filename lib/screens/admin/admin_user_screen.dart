import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminUserScreen extends StatefulWidget {
  const AdminUserScreen({Key? key}) : super(key: key);

  @override
  State<AdminUserScreen> createState() => _AdminUserScreenState();
}

class _AdminUserScreenState extends State<AdminUserScreen> {
  final Stream<QuerySnapshot<Object>> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
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
           return const Center(
              child: CircularProgressIndicator(),
            );
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
                                  NetworkImage('${data['avatarUrl']}'),
                            ),
                            title: Text('${data['username']}'),
                            subtitle: Text(
                                'Email: ${data['email']}\nBio: ${data['bio']}\nAdmin: ${data['isAdmin']}\nUID: ${data['uid']}',),
                            trailing: PopupMenuButton<String>(
                              itemBuilder: (BuildContext context) {
                                return <PopupMenuEntry<String>>[
                                  PopupMenuItem<String>(
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
                            ),),
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
