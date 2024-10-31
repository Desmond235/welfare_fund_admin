import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:welfare_fund_admin/core/constants/constants.dart';
import 'package:welfare_fund_admin/core/constants/palette.dart';
import 'package:welfare_fund_admin/core/controls/obscure_text.dart';
import 'package:welfare_fund_admin/core/service/change_password_service.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangPasswordScreenState();
}

class _ChangPasswordScreenState extends State<ChangePasswordScreen> {
  bool showPassword = false;
  final passwordController = TextEditingController();
  final obscureTextController = ObscuringTextEditingController();

  void changePassword() {
    ChangePasswordService.post(
      passwordController.text,
      context,
      passwordController,
    );
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    obscureTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: KeyboardDismissOnTap(
            child: Column(
              children: [
                const Text(
                  'Enter new Password',
                  style: TextStyle(fontSize: 17),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller:
                      showPassword ? passwordController : obscureTextController,
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
                          obscureTextController.text = passwordController.text;
                          obscureTextController.selection =
                              TextSelection.collapsed(
                            offset: obscureTextController.text.length,
                          );
                        } else {
                          passwordController.text = obscureTextController.text;
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
                const SizedBox(height: 30),
                InkWell(
                  onTap: changePassword,
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
