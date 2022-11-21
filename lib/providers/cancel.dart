import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Cancel with ChangeNotifier {
  Future<void> reFund(String merchantUid,String productId,num total) async {
    try {
      final url = Uri.parse("https://api.iamport.kr/users/getToken");
      var _res = await http.post(url,
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({
            'imp_key': "7025268508462361", // REST API키
            'imp_secret':
                'uJLazQEqjugDRMQs4qys56HwvhIMuyLOGQhd2URwAgkB3an78uqFm3gDOk6af4TTxNFcW3fLiaLSlH2i'
          }));
 print(json.decode(_res.body));
      var access_token = json.decode(_res.body)['response']['access_token'];
      print(access_token);
      final url2 = Uri.parse("https://api.iamport.kr/payments/cancel");
      var _res2 = await http.post(url2,
          headers: {
            "Content-Type": "application/json",
            "Authorization":
                access_token /*"Bearer a9ace025c90c0da2161075da6ddd3492a2fca776"*/
          },
          body: json.encode({
  
            'reason': '결제 취소',
            'merchant_uid': merchantUid,
            'amount': total,

          }));
      print(json.decode(_res2.body)['response']);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

}
