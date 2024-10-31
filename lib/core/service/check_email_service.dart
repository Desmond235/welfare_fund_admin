import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:welfare_fund_admin/core/constants/constants.dart';
import 'package:welfare_fund_admin/core/controls/snackbar.dart';
import 'package:welfare_fund_admin/core/service/send_otp.dart';

class CheckEmailService {
  static void sendOtp( String email, BuildContext context) async{
    final prefs = await sharedPrefs;
    prefs.setString('email', email);
    if(!context.mounted) return;
    SendOtpResponse.post(email, context);
  }
  static void post(String email, BuildContext context) async {
    const baseUrl = 'http://10.0.2.2:3000/api/admin/';
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}check-email'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email}),
      );

      if(!context.mounted) return;
      if(response.statusCode == 200){
       sendOtp(email, context);
      }else{
        snackBar(context, 'Please enter the email address you added to your account');
      }
    } on Exception catch (e) {
      snackBar(context, e.toString());
    }
  }
}
