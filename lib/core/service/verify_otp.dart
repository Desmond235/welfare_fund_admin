import 'dart:developer';

import 'package:http/http.dart' as http;

class VerifyOtpResponse {
  static post(String otp) async {
    try {
      const verifyOtpUrl = 'http://10.0.2.2:3000/api/v1/';
      final response = await http.post(
        Uri.parse('${verifyOtpUrl}verify-email'),

        // headers:{
        //   'Content-Type': 'application/json'
        //   },

        body: {'otp': otp},
      );
      if(response.statusCode == 200){
        print('otp verified successfully');
      }
      else{
        print('opt is incorrect');
      }
    } on Exception catch (e) {
      print('An error occurred while verifying otp');
    }
  }
}