import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jajungjin/screen/pages/receipt_detail_screen.dart';

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({super.key});
  static const routeName = '/receipt';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('receipt')
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
                var total =
                    docs?[index]['price'] * docs?[index]['selectedAmount'];
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            ReceiptDetailScreen.routeName,
                            arguments: {
                              'foodName': docs?[index]['foodName'],
                              'createdAt': docs?[index]['createdAt'],
                              'price': docs?[index]['price'],
                              'productId': docs?[index]['productId'],
                              'selectedAmount': docs?[index]['selectedAmount'],
                              'merchantUid': docs?[index]['merchantUid'],
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          title: Text(
                            '${docs?[index]['foodName']}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              '${total}원',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          trailing: Column(
                            children: [
                              Text(
                                DateFormat.Hm().format(
                                    (docs?[index]['createdAt']).toDate()),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Divider(indent: 85),
                  ],
                );
                ;
              },
            ),
          );
        },
      )),
    );
  }
}
