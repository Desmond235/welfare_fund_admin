import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:welfare_fund_admin/core/components/dialog_box.dart';
import 'package:welfare_fund_admin/core/components/input_control.dart';
import 'package:welfare_fund_admin/core/constants/constants.dart';
import 'package:welfare_fund_admin/core/service/update_credentials.dart';
import 'package:welfare_fund_admin/features/auth/widgets/text_input.dart';

class ChangeCredentials extends StatefulWidget {
  const ChangeCredentials({super.key});

  @override
  State<ChangeCredentials> createState() => _ChangeCredentialsState();
}

class _ChangeCredentialsState extends State<ChangeCredentials> {
  final TextEditingController passwordController = TextEditingController();
  final usernameController = TextEditingController();

  void updateCredentials() {
    UpdateCredentialsResponse.post(
      usernameController.text,
      passwordController.text,
      context,
      usernameController,
      passwordController
    );
  }

   @override
    void dispose() {
      super.dispose();
        usernameController.dispose();
        passwordController.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (value, result) {
        dialogBox(context);
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Change your username and password",
                  style: TextStyle(color: priCol(context), fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: BuildTextInput(
                    controller: usernameController,
                    hintText: 'username',
                    icon: MaterialCommunityIcons.account_outline,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextInput(passwordController: passwordController)),
                const SizedBox(height: 20),
                InkWell(
                  onTap: updateCredentials,
                  borderRadius: BorderRadius.circular(35),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft,
                          colors: [
                            priCol(context).withOpacity(0.6),
                            priCol(context)
                          ],
                        )),
                    child: const Text(
                      'Save',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
