import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jajungjin/widgets/pickers/user_image_picker.dart';
import 'package:uuid/uuid.dart';

class PlusItemScreen extends StatefulWidget {
  static const routeName = 'plus-item';

  @override
  State<PlusItemScreen> createState() => _PlusItemScreenState();
}

class _PlusItemScreenState extends State<PlusItemScreen> {
  final _formKey = GlobalKey<FormState>();

  var _foodName = '';
  var _description = '';
  File? _userImageFile;

  var _price = '';

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  Future<void> sendData(foodName, description, price, userImageFile) async {
    try {
      final currenUserUid = FirebaseAuth.instance.currentUser?.uid;
      final ref = FirebaseStorage.instance
          .ref()
          .child('foodName')
          .child('${Timestamp.now()}.jpg');

      await ref.putFile(userImageFile!);

      final url = await ref.getDownloadURL();
       final productId = Uuid().v1();
      await FirebaseFirestore.instance //메시지 생성
          .collection('items')
          .add({
        'foodName': foodName,
        'createdAt': Timestamp.now(),
        'description': description,
        'price': int.parse(price),
        'image_url': url,
        'productId': productId
      });
    } catch (error) {
      print(error);
    }
  }

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if (_userImageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please pick an image.'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }
    if (isValid!) {
      _formKey.currentState?.save();
      sendData(
          _foodName.trim(), _description.trim(), _price.trim(), _userImageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              _trySubmit();
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.add))
      ]),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      UserImagePicker(_pickedImage),
                      TextFormField(
                        key: ValueKey('foodName'),
                        autocorrect: true,
                        textCapitalization: TextCapitalization.words,
                        enableSuggestions: false,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 4) {
                            return 'Please enter at least 4 characters.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Food Name'),
                        onSaved: (value) {
                          _foodName = value as String;
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        key: ValueKey('description'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a description.';
                          }
                          if (value.length < 10) {
                            return 'Should be  at least 10 characters long.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Description'),
                        onSaved: (value) {
                          _description = value as String;
                        },
                      ),
                      TextFormField(
                        key: ValueKey('price'),
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        enableSuggestions: false,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a valid price.';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'price'),
                        onSaved: (value) {
                          _price = value.toString();
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
