import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:welfare_fund_admin/core/components/dialog_box.dart';
import 'package:welfare_fund_admin/core/components/input_control.dart';
import 'package:welfare_fund_admin/core/constants/constants.dart';
import 'package:welfare_fund_admin/core/service/add_email_service.dart';
import 'package:welfare_fund_admin/core/service/update_credentials.dart';
import 'package:welfare_fund_admin/features/auth/widgets/text_input.dart';

class AddEmail extends StatefulWidget {
  const AddEmail({super.key});

  @override
  State<AddEmail> createState() => _AddEmailState();
}

class _AddEmailState extends State<AddEmail> {
  final emailController = TextEditingController();

  void addEmail() {
    AddEmailService.post(emailController.text, context);
  }

   @override
    void dispose() {
      super.dispose();
        emailController.dispose();
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
                  "Add email address",
                  style: TextStyle(color: priCol(context), fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: BuildTextInput(
                    controller: emailController,
                    hintText: 'email',
                    icon: MaterialCommunityIcons.account_outline,
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: addEmail ,
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
                      'Add',
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
