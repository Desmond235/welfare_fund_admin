import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:welfare_fund_admin/core/controls/snackbar.dart';
import 'package:welfare_fund_admin/features/auth/providers/change_credentials_provider.dart';

class VerifyLogin {
  static post(String username, String password, BuildContext context, ChangeCredentialsProvider credentialsState) async {
    const loginUrl = 'http://10.0.2.2:3000/api/admin/login';

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

      if (response.statusCode == 200) {
        if (context.mounted) {
          credentialsState.isChangeCredentials
              ? Navigator.of(context).pushNamed('main')
              : Navigator.of(context).pushReplacementNamed('changeCredentials');
        }
        print('login successful');
      } else {
        if (context.mounted) {
          return snackBar(context, 'Username or password is incorrect');
        }
      }
    } on Exception catch (e) {
      if (context.mounted) {
        return snackBar(context, 'An error occurred: $e');
      }
    }
  }
}
