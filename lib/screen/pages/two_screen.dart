// import 'package:flutter/material.dart';

// class TwoScreen extends StatelessWidget {
//   const TwoScreen({super.key});
//   static const routeName = '/two';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: Text('two')),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TwoScreen extends StatelessWidget {
 

  TwoScreen();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('items')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapshot.data?.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs?.length,
          itemBuilder: (context, index) => Text('data')
          // MessageBubble(
          //   chatDocs?[index]['text'],
          //   FirebaseAuth.instance.currentUser?.uid ==
          //       chatDocs?[index]['userId'],
          //   chatDocs?[index]['username'],
          //   chatDocs?[index]['image_url'],
          //   key: ValueKey(chatDocs?[index].id),
          // ),
        );
      },
    );
  }
}
