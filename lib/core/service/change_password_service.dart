
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:welfare_fund_admin/core/constants/constants.dart';
import 'package:welfare_fund_admin/core/controls/snackbar.dart';
import 'package:welfare_fund_admin/features/auth/providers/change_credentials_provider.dart';

class ChangePasswordService {
  static post(
    String password,
    BuildContext context,
    TextEditingController passwordController,
  ) async {
    const loginUrl = 'http://10.0.2.2:3000/api/admin/change-password';

    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {
            'password': password,
          },
        ),
      );

      if (!context.mounted) {
        return;
      }
      if (response.statusCode == 200) {
        if (passwordController.text.isEmpty) {
        snackBar(context, "password cannot be empty");
        return;
      }
        dialog(context);
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
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('auth', (_) => false);
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
