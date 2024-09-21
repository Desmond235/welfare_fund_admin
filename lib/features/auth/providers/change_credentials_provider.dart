import 'package:flutter/material.dart';
import 'package:welfare_fund_admin/core/constants/constants.dart';

class ChangeCredentialsProvider extends ChangeNotifier {
  bool ? _isChangeCredentials;
  bool? _isSignedIn;
  bool get isChangeCredentials => _isChangeCredentials ?? false;
  bool get isSignedIn => _isSignedIn?? false;
  
  // checking if the user has signed in
  void setIsSignedIn(bool? value) {
    _isSignedIn = value;
    saveSignedIn();
    notifyListeners();
  }

  void saveSignedIn() async{
    final prefs = await sharedPrefs;
    prefs.setBool('isSignedIn', _isSignedIn!);
  }

  void getIsSignedIn() async{
    final prefs = await sharedPrefs;
    _isSignedIn = prefs.getBool('isSignedIn') ?? false;
    notifyListeners();
  }


// change credentials
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