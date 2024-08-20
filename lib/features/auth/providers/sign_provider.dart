import 'package:flutter/material.dart';
import 'package:welfare_fund_admin/core/constants/constants.dart';

class SignInProvider extends ChangeNotifier {
  String username = '';
 String password = '';
 bool _isSignin = false;
 bool get isSignin => _isSignin;

 void setSignIn(bool value){
   _isSignin = value;
   saveSigninSate();
   notifyListeners();
 }

// save signin state to shared preferences
 void saveSigninSate() async{
  final prefs = await sharedPrefs;
  prefs.setBool('isSignin', _isSignin );
 }

// removes signin state from shared preferences
 void removeSigninSate() async{
  final prefs  = await sharedPrefs;
  prefs.remove('isSignin');
 }

// get signin state from shared preferences
 void getSigninState() async{
  final prefs = await sharedPrefs;
  _isSignin = prefs.getBool('isSignin')?? false;
  notifyListeners();
 }
  
  void saveUsername(String? value){
    username = value!;
  }
  
  void savePassword(String? value){
    password = value!;
  }
}
