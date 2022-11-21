import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class Connect with ChangeNotifier {
  List _result = [];
  bool _isCheck = false;

  bool get isCheck => _isCheck;
  set isCheck(bool newCheck) => throw "ERR ISCHECK";

  List get result => _result;
  set result(List newResult) => throw "ERRRSETTER";

  Future<void> fetch() async {
    try {
      final url = Uri.parse("http://192.168.195.23:3000/items");
      var _res = await http.get(url);
      _result = json.decode(_res.body);
      _isCheck = !_isCheck;
    } catch (e) {
      _isCheck = false;
      print(e);
    }
    notifyListeners();
  }
}
