import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import 'package:welfare_fund_admin/core/controls/snackbar.dart';

class SendOtpResponse {
  static post(String email, BuildContext context) async {
    try {
      const otpUrl = 'http://10.0.2.2:3000/api/v1/';

      final data = {"email": email};

      final response = await http.post(
        Uri.parse('${otpUrl}send-email'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data)
      );

      if(!context.mounted){
        return;
      }
      if(response.statusCode == 200){
        Navigator.of(context).pushNamed('otp');
      }
      else{
        snackBar(context, 'Could not send otp, please check your internet connection ');
      }
    } on Exception catch (e) {
      print('An error occurred while sending otp: $e');
    }
  }
}
