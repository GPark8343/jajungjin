import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jajungjin/widgets/chat/messages.dart';
import 'package:jajungjin/widgets/chat/new_message.dart';

class UserChatScreen extends StatelessWidget {
  const UserChatScreen({super.key});
  static const routeName = 'user-chat-screen';
  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser?.uid as String;
    return Container(
      child: Column(
        children: [
          Expanded(child: Messages(userId)),
          NewMessage(userId),
        ],
      ),
    );
  }
}
