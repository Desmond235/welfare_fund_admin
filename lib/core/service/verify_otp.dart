import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:welfare_fund_admin/core/controls/snackbar.dart';

class VerifyOtpResponse {
  static post(String otp, BuildContext context) async {
    try {
      const verifyOtpUrl = 'http://10.0.2.2:3000/api/v1/';
      final response = await http.post(
        Uri.parse('${verifyOtpUrl}verify-email'),

        // headers:{
        //   'Content-Type': 'application/json'
        //   },

        body: {'otp': otp},
      );
      if(!context.mounted) return;
      if(response.statusCode == 200){
        if(context.mounted){
          Navigator.of(context).pushReplacementNamed('password');
        }
      }
      else{
        snackBar(context, 'Otp incorrect or expired');
      }
    } on Exception {
      if(context.mounted){
         return snackBar(context, 'An error occurred while verifying otp');
      }
     
    }
  }
}
