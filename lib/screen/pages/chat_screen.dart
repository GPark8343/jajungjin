import 'package:flutter/material.dart';
import 'package:jajungjin/widgets/chat/messages.dart';
import 'package:jajungjin/widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  static const routeName = 'chat-screen';
  @override
  Widget build(BuildContext context) {
    final userId =
        (ModalRoute.of(context)?.settings.arguments as Map)['userId'] as String;
            final username =
        (ModalRoute.of(context)?.settings.arguments as Map)['username'] as String;
    return Scaffold(appBar: AppBar(title: Text(username)),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages(userId)),
            NewMessage(userId),
          ],
        ),
      ),
    );
  }
}
