import 'package:flutter/material.dart';
import 'package:welfare_fund_admin/core/components/input_control.dart';
import 'package:welfare_fund_admin/core/constants/constants.dart';
import 'package:welfare_fund_admin/core/service/check_email_service.dart';
import 'package:welfare_fund_admin/core/service/send_otp.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final emailController = TextEditingController();

  void sendOtp(){
    SendOtpResponse.post(emailController.text, context);
  }

  void checkEmail() async{
    CheckEmailService.post(emailController.text.trim(), context);
  }

   @override
    void dispose() {
      super.dispose();
        emailController.dispose();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            children: [
              const Text('Enter Email', style: TextStyle(fontSize: 18, color: Colors.grey),),
              const SizedBox(height: 20),
              BuildTextInput(
                controller: emailController,
                icon: Icons.email_outlined,
                hintText: 'Email',
                isEmail: true,
                // validation for email
                validator: (value) {
                  if (value!.trim().isEmpty ||
                      !RegExp(r'\S\@\S+\.\S', caseSensitive: false)
                          .hasMatch(value.trim())) {
                    return 'Please enter a valid email address;';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              InkWell(
                  onTap: checkEmail,
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
                      'Continue',
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
    );
  }
}
