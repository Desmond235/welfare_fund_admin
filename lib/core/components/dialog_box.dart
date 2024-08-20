
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dialogBox(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(Icons.exit_to_app),
          content: const Text(
            "Are you sure you want to exit?",
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
                // canPop = true;
              },
              child: const Text('Yes'),
            ),
          ],
        );
      });
}
