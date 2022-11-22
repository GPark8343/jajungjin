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
        body: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('receipts')
          .where('currentUserUid',
              isEqualTo: FirebaseAuth.instance.currentUser?.uid)
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
            shrinkWrap: true,
            itemCount: docs?.length,
            itemBuilder: (context, index) {
              var total = (docs?[index]['price'] ?? 0 as num) *
                  (docs?[index]['selectedAmount'] ?? 0 as num);
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(ReceiptDetailScreen.routeName, arguments: {
                        'foodName': docs?[index]['foodName'],
                        'createdAt': docs?[index]['createdAt'],
                        'price': docs?[index]['price'],
                        'productId': docs?[index]['productId'],
                        'selectedAmount': docs?[index]['selectedAmount'],
                        'merchantUid': docs?[index]['merchantUid'],
                        'complete': docs?[index]['complete'],
                        'refund': docs?[index]['refund']
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
                                        docs?[index]['refund']
                                            ? '환불 완료 ${DateFormat.Hm().format((docs?[index]['createdAt']).toDate())}'
                                            : (docs?[index]['complete']
                                                ? '완료 ${DateFormat.Hm().format((docs?[index]['createdAt']).toDate())}'
                                                : '미완료 ${DateFormat.Hm().format((docs?[index]['createdAt']).toDate())}'),
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
    ));
  }
}
