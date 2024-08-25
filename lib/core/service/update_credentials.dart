import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:welfare_fund_admin/core/constants/constants.dart';
import 'package:welfare_fund_admin/core/controls/snackbar.dart';

class UpdateCredentialsResponse {
  static post(String username, String password, BuildContext context) async {
    const loginUrl = 'http://localhost:3000/api/admin/update_credentials';

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

      if (!context.mounted) {
        return;
      }
      if (response.statusCode == 200) {
       dialog(context);
      } else {
        snackBar(context, 'Failed update credentials');
      }
    } on Exception catch (e) {
      snackBar(context, 'An error occurred: $e');
    }
  }
}

Future<void> dialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('Credentials updated successfully'),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed('main'),
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
