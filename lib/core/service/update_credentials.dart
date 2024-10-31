import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:welfare_fund_admin/core/constants/constants.dart';
import 'package:welfare_fund_admin/core/controls/snackbar.dart';
import 'package:welfare_fund_admin/features/auth/providers/change_credentials_provider.dart';

class UpdateCredentialsResponse {
  static post(
    String username,
    String password,
    BuildContext context,
    TextEditingController usernameController,
    TextEditingController passwordController,
  ) async {
    const loginUrl = 'http://10.0.2.2:3000/api/admin/update-credentials';

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
        if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
        return snackBar(context, "username or password cannot be empty");
      }
        dialog(context);
        context.read<ChangeCredentialsProvider>().setIsChangeCredentials(true);
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
                    .pushNamedAndRemoveUntil('addEmail', (_) => false);
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
