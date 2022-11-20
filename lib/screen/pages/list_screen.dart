import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jajungjin/widgets/item.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});
  static const routeName = 'list';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('items')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final docs = snapshot.data?.docs;
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: docs?.length,
            itemBuilder: (context, index) {
              print(docs?[index]['image_url'].toString());
              return Item(docs?[index]['foodName'], docs?[index]['description'],
                  docs?[index]['image_url'], docs?[index]['price'], docs?[index]['createdAt'], docs?[index]['productId']);
            },
          ),
        );
      },
    );
  }
}
