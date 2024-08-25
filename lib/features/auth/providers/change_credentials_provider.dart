import 'package:flutter/material.dart';
import 'package:welfare_fund_admin/core/constants/constants.dart';

class ChangeCredentialsProvider extends ChangeNotifier {
  bool ? _isChangeCredentials;
  bool get isChangeCredentials => _isChangeCredentials ?? false;

  void setIsChangeCredentials(bool? value) {
    _isChangeCredentials = value;
    saveCredentials();
    notifyListeners();
  }

  void saveCredentials() async{
    final prefs = await sharedPrefs;
    prefs.setBool('isChangeCredentials', _isChangeCredentials!);
  }

  void getCredentials() async{
    final prefs = await sharedPrefs;
   _isChangeCredentials = prefs.getBool('isChangeCredentials') ?? false;
    notifyListeners();
  }
}