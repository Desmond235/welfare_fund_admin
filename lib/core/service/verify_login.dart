import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:welfare_fund_admin/core/controls/snackbar.dart';

class VerifyLogin {
  static post(String username, String password, BuildContext context) async {
    const loginUrl = 'http://localhost:3000/api/admin/login';

    try {
       final response = await http.post(
      Uri.parse(loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'username': username,
          'password': password,
        },
      ),
    );
     
     if(!context.mounted){
      return ;
     }
    if(response.statusCode ==200){
      print('login successful');
    } else{
      snackBar(context, 'Username or password is incorrect');
    }
    } on Exception catch (e) {
      snackBar(context, 'An error occurred: $e');
    }
   
  }
}
