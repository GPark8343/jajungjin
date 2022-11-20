import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jajungjin/screen/pages/i_am_port_payment_screen.dart';
import 'package:provider/provider.dart';

class ItemDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title,this.price);
  static const routeName = '/item-detail';
  @override
  Widget build(BuildContext context) {
    final productId = (ModalRoute.of(context)?.settings.arguments
        as Map)['productId'] as String;
    final foodName = (ModalRoute.of(context)?.settings.arguments
        as Map)['foodName'] as String;
    final description = (ModalRoute.of(context)?.settings.arguments
        as Map)['description'] as String;
    final price =
        (ModalRoute.of(context)?.settings.arguments as Map)['price'] as num;
    final createdAt = (ModalRoute.of(context)?.settings.arguments
        as Map)['createdAt'] as Timestamp;
    final imageUrl = (ModalRoute.of(context)?.settings.arguments
        as Map)['image_url'] as String;

    // ...
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(foodName),
              background: Hero(
                tag: productId,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 10,
            ),
            Text(
              '${price}won',
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
                description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            SizedBox(
              height: 800,
            ),
            ElevatedButton(
              child: Text('결제 고'),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(IamportPaymentScreen.routeName, arguments: {
                  'productId': productId,
                  'foodName': foodName,
                  'price': price,
                });
              },
            )
          ]))
        ],
      ),
    );
  }
}
