import 'package:flutter/material.dart';

class UserName with ChangeNotifier {
  String _userName = "";

  String get userName => _userName;

  void setUserName(String userName) {
    _userName = userName;
    notifyListeners();
  }
}
