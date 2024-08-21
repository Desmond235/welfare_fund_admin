
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:welfare_fund_admin/core/constants/palette.dart';
import 'package:welfare_fund_admin/core/controls/obscure_text.dart';
import 'package:welfare_fund_admin/features/auth/providers/sign_provider.dart';

class TextInput extends StatefulWidget {
  const TextInput({super.key, required this.passwordController});
  final TextEditingController passwordController;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool showPassword = true;
  final ObscuringTextEditingController obscurePasswordController = ObscuringTextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
              style: const TextStyle(color: Colors.black),
              controller: showPassword
                  ? widget.passwordController
                  : obscurePasswordController,
              onSaved: (value) {
                Provider.of<SignInProvider>(context, listen: false)
                    .savePassword(value!);
              },
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
                      obscurePasswordController.text =
                          widget.passwordController.text;
                      obscurePasswordController.selection =
                          TextSelection.collapsed(
                        offset: obscurePasswordController.text.length,
                      );
                    } else {
                      widget.passwordController.text =
                          obscurePasswordController.text;
                      widget.passwordController.selection =
                          TextSelection.collapsed(
                        offset: widget.passwordController.text.length,
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
            );
  }
}