import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jajungjin/providers/cancel.dart';
import 'package:jajungjin/screen/pages/i_am_port_payment_screen.dart';
import 'package:provider/provider.dart';

class ReceiptDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title,this.price);
  static const routeName = '/receipt-detail';
  @override
  Widget build(BuildContext context) {
    final productId =
        (ModalRoute.of(context)?.settings.arguments as Map)['productId'];
    final foodName = (ModalRoute.of(context)?.settings.arguments
        as Map)['foodName'] as String;
    final price =
        (ModalRoute.of(context)?.settings.arguments as Map)['price'] as num;
    final selectedAmount = (ModalRoute.of(context)?.settings.arguments
        as Map)['selectedAmount'] as num;
    final createdAt = (ModalRoute.of(context)?.settings.arguments
        as Map)['createdAt'] as Timestamp;
    var total = price * selectedAmount;
    final merchantUid = (ModalRoute.of(context)?.settings.arguments
        as Map)['merchantUid'] as String;
    final complete =
        (ModalRoute.of(context)?.settings.arguments as Map)['complete'] as bool;
    final refund =
        (ModalRoute.of(context)?.settings.arguments as Map)['refund'] as bool;
    bool isManager = FirebaseAuth.instance.currentUser?.uid ==
        'MLZicFwQROVuFd36qz7dc59EiBm2';
    // ...
    return Scaffold(
        appBar: AppBar(
          title: Text('결제 영수증'),
          actions: isManager
              ? [
                  IconButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance //메시지 생성
                            .collection('receipts')
                            .doc(merchantUid)
                            .update({'complete': true});
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.check))
                ]
              : [],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              '${foodName}',
              style: TextStyle(color: Colors.black, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${total}won',
              style: TextStyle(color: Colors.grey, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                '    description',
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            (complete || refund)
                ? Container()
                : ElevatedButton(
                    child: Text('환불 고'),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      final cancel =
                          Provider.of<Cancel>(context, listen: false);
                      cancel.reFund(merchantUid, productId, total);

                      await FirebaseFirestore.instance //메시지 생성
                          .collection('items')
                          .doc(productId)
                          .get()
                          .then((value) async {
                        await FirebaseFirestore.instance //메시지 생성
                            .collection('items')
                            .doc(productId)
                            .update({
                          'amount': value.data()?['amount'] + selectedAmount
                        });
                      });

                      await FirebaseFirestore.instance //메시지 생성
                          .collection('receipts')
                          .doc(merchantUid)
                          .update({'refund': true});
                    },
                  )
          ],
        ));
  }
}
