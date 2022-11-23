import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  final String userId;
  NewMessage(this.userId);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final _controller = new TextEditingController();

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    _controller.clear();
    final user =
        FirebaseAuth.instance.currentUser; // 지금은 currentuser가 Future이 아님
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.userId)
        .collection('messages')
        .add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user?.uid,
      'username': userData['username'],
      'image_url': userData['image_url']
    });
    bool isManager = FirebaseAuth.instance.currentUser?.uid ==
        'MLZicFwQROVuFd36qz7dc59EiBm2';
    if (isManager) {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.userId)
          .update({
     
        'last_message': _enteredMessage,
        'createdAt': Timestamp.now(),
      });
    } else {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.userId)
          .set({
        'userId': user?.uid,
        'username': userData['username'],
        'image_url': userData['image_url'],
        'last_message': _enteredMessage,
        'createdAt': Timestamp.now(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: InputDecoration(labelText: 'Send a message...'),
            onChanged: (value) {
              setState(() {
                _enteredMessage = value;
              });
            },
          )),
          IconButton(
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
