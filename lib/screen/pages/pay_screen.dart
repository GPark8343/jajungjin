import 'package:flutter/material.dart';

/* 아임포트 결제 모듈을 불러옵니다. */
import 'package:iamport_flutter/iamport_payment.dart';
/* 아임포트 결제 데이터 모델을 불러옵니다. */
import 'package:iamport_flutter/model/payment_data.dart';
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
      )),
    );
  }
}
