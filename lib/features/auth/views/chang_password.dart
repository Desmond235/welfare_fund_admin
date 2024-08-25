import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:welfare_fund_admin/core/constants/palette.dart';
import 'package:welfare_fund_admin/core/controls/obscure_text.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangPasswordScreenState();
}

class _ChangPasswordScreenState extends State<ChangePasswordScreen> {
  bool showPassword = true;
  final passwordController = TextEditingController();
  final obscureTextController = ObscuringTextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Change Password'
              ),
              TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: showPassword
                        ? passwordController
                        : obscureTextController,
                    // onSaved: (value) {
                    //   Provider.of<SignInProvider>(context, listen: false)
                    //       .savePassword(value!);
                    // },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Password",
                      hintStyle: const TextStyle(color: Palette.textColor1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: const BorderSide(color: Palette.textColor1),
                      ),
                      prefixIcon: const Icon(
                        MaterialCommunityIcons.lock,
                        color: Palette.textColor1,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (showPassword) {
                            obscureTextController.text =
                                passwordController.text;
                            obscureTextController.selection =
                                TextSelection.collapsed(
                              offset: obscureTextController.text.length,
                            );
                          } else {
                            passwordController.text =
                                obscureTextController.text;
                            passwordController.selection =
                                TextSelection.collapsed(
                              offset: passwordController.text.length,
                            );
                          }
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: Icon(
                          showPassword ? Icons.visibility : Icons.visibility_off,
                          color: Palette.iconColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: const BorderSide(color: Palette.textColor1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: const BorderSide(color: Palette.textColor1),
                      ),
                    ),
                  ),
            ],
          ), 
        ),
      ),
    );
  }
}
