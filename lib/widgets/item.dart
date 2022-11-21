import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jajungjin/screen/pages/item_detail_screen.dart';

class Item extends StatelessWidget {
  final String foodName;
  final String imageUrl;
  final price;
  final String description;
  final Timestamp createdAt;
  final String productId;
  final amount;

  const Item(this.foodName, this.description, this.imageUrl, this.price,
      this.createdAt, this.productId, this.amount);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            await Navigator.of(context)
                .pushNamed(ItemDetailScreen.routeName, arguments: {
              'productId': productId,
              'foodName': foodName,
              'description': description,
              'price': price,
              'createdAt': createdAt,
              'image_url': imageUrl,
              'amount': amount,
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ListTile(
              title: Text(
                '$foodName(${price}원)',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  description,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  imageUrl,
                ),
                radius: 30,
              ),
              trailing: Text(
             '${amount}개 남음 ${DateFormat.Hm().format((createdAt).toDate())}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
        const Divider(indent: 85),
      ],
    );
  }
}
