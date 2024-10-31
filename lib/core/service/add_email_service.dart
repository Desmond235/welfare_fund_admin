import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:welfare_fund_admin/core/constants/constants.dart';
import 'package:welfare_fund_admin/core/controls/snackbar.dart';
import 'package:welfare_fund_admin/features/auth/providers/change_credentials_provider.dart';
class AddEmailService {
  static Future<void> post(String email, BuildContext context) async {
    const baseUrl = 'http://10.0.2.2:3000/api/admin/';
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}add-email'),
        headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email})
      );
      if(!context.mounted) return ;

      if(response.statusCode == 200){
        dialog(context);
      }else{
        snackBar(context, 'Failed to add email');
      }
      
    } on Exception catch (e) {
      snackBar(context, e.toString());
    }
  }
}

Future<void> dialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Email'),
          content: const Text('email added successfully'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('main', (_) => false);
                Provider.of<ChangeCredentialsProvider>(context, listen: false)
                    .setIsChangeCredentials(true);
              },
              child: Text(
                'Ok',
                style: TextStyle(
                  color: priCol(context),
                ),
              ),
            )
          ],
        );
      });
}