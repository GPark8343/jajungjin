import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jajungjin/screen/pages/i_am_port_payment_screen.dart';
import 'package:provider/provider.dart';

class ItemDetailScreen extends StatefulWidget {
  static const routeName = '/item-detail';

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  // final String title;
  final _formKey = GlobalKey<FormState>();
  bool isManager =
      FirebaseAuth.instance.currentUser?.uid == 'MLZicFwQROVuFd36qz7dc59EiBm2';
  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();

    if (isValid!) {
      _formKey.currentState?.save();
    }
  }

  var _selectedamount = null;
  @override
  Widget build(BuildContext context) {
    final productId =
        (ModalRoute.of(context)?.settings.arguments as Map)['productId'];
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
    final amount =
        (ModalRoute.of(context)?.settings.arguments as Map)['amount'] as num;
    // ...
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: const CircularProgressIndicator(),
                              );
                            }
          final username = snapshot.data?.data()?['username'];
     
          return Scaffold(
              appBar: AppBar(
                title: Text(foodName),
                actions: isManager
                    ? [
                        IconButton(
                            onPressed: () async {
                              await FirebaseFirestore.instance //메시지 생성
                                  .collection('items')
                                  .doc(productId)
                                  .delete();
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.delete)),
                      ]
                    : [],
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 10,
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Container(
                          height: 150,
                          width: double.infinity,
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
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
                        Text(
                          '${amount}개',
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
                          height: 10,
                        ),
                       amount<=0? Container():  Form(
                          key: _formKey,
                          child: TextFormField(
                            key: ValueKey('selectedAmount'),
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            enableSuggestions: false,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            validator: (value) {
                              if (value!.isEmpty || int.parse(value) == 0) {
                                return 'Please enter a valid amount.';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(labelText: 'selectedAmount'),
                            onSaved: (value) {
                              _selectedamount = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                   amount<=0?   Text('Sold Out'):  ElevatedButton(
                          child: Text('결제 고'),
                          onPressed: () {
                            _trySubmit();
                            if (_selectedamount != null &&
                                int.parse(_selectedamount) <= amount) {
                              Navigator.of(context).pushNamed(
                                  IamportPaymentScreen.routeName,
                                  arguments: {
                                    'productId': productId,
                                    'foodName': foodName,
                                    'price': price,
                                    'selectedAmount':
                                        int.parse(_selectedamount),
                                    'amount': amount,
                                    'username':username
                                  });
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}
