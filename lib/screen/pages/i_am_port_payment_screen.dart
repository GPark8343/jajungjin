import 'package:flutter/material.dart';

/* 아임포트 결제 모듈을 불러옵니다. */
import 'package:iamport_flutter/iamport_payment.dart';
/* 아임포트 결제 데이터 모델을 불러옵니다. */
import 'package:iamport_flutter/model/payment_data.dart';

class IamportPaymentScreen extends StatelessWidget {
  static const routeName = 'pay-screen';
  const IamportPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IamportPayment(
      appBar: new AppBar(
        title: new Text('아임포트 결제'),
      ),
      /* 웹뷰 로딩 컴포넌트 */
      initialChild: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/iamport-logo.png'),
              Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
      /* [필수입력] 가맹점 식별코드 */
      userCode: 'imp02341435',
      /* [필수입력] 결제 데이터 */
      data: PaymentData(
          pg: 'html5_inicis', // PG사
          payMethod: 'card', // 결제수단
          name: '아임포트 결제데이터 분석', // 주문명
          merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}', // 주문번호
          amount: 100, // 결제금액
          buyerName: '홍길동', // 구매자 이름
          buyerTel: '01012345678', // 구매자 연락처
          buyerEmail: 'example@naver.com', // 구매자 이메일

          appScheme: 'example', // 앱 URL scheme
          displayCardQuota: [2, 3] //결제창 UI 내 할부개월수 제한
          ),
      /* [필수입력] 콜백 함수 */
      callback: (Map<String, String> result) {
        Navigator.of(context).pop();
      },
    );
  }
}