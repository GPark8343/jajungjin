import 'package:flutter/material.dart';

import 'package:jajungjin/screen/pages/i_am_port_payment_screen.dart';

class PayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        child: Text('결제 고'),
        onPressed: () {
          Navigator.of(context).pushNamed(IamportPaymentScreen.routeName);
        },
      )
      ),
    );
  }
}
