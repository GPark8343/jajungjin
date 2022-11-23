import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jajungjin/screen/pages/receipt_detail_screen.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});
  static const routeName = '/user-management';
//  await FirebaseFirestore.instance
//             .collection('users')
//             .doc(authResult.user?.uid)
//             .set({
//           'username': username.toString(),
//           'email': email,
//           'image_url': url,
//           'uid': authResult.user?.uid,
//           'isBan':true
//         });
  @override
  Widget build(BuildContext context) {
    bool isManager = FirebaseAuth.instance.currentUser?.uid ==
        'MLZicFwQROVuFd36qz7dc59EiBm2';
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (ctx, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: const CircularProgressIndicator(),
          );
        }
        final userDocs = userSnapshot.data?.docs;
        return ListView.builder(
            itemCount: userDocs?.length,
            itemBuilder: (context, index) {
              return userDocs?[index]['uid'] == 'MLZicFwQROVuFd36qz7dc59EiBm2'
                  ? Container()
                  : Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ListTile(
                              title: Text(
                                userDocs?[index]['username'],
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              trailing: TextButton(
                                child: userDocs?[index]['isBan']?Text('차단 해제'):Text('차단'),
                                onPressed: () async {
                                  if(userDocs?[index]['isBan'])
                                {  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(userDocs?[index]['uid'])
                                      .update({'isBan': false});}else {  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(userDocs?[index]['uid'])
                                      .update({'isBan': true});}
                                },
                              ),
                            ),
                          ),
                        ),
                        const Divider(indent: 85),
                      ],
                    );
            });
      },
    );
  }
}
