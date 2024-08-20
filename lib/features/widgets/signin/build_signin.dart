import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:welfare_fund_admin/core/components/input_control.dart';
import 'package:welfare_fund_admin/core/constants/palette.dart';
import 'package:welfare_fund_admin/core/controls/obscure_text.dart';
import 'package:welfare_fund_admin/features/auth/providers/sign_provider.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({
    super.key,
    this.isRememberMe,
    this.username,
    required this.chkOnchanged,
    required this.onChanged,
    required this.passwordController,
  });


  final void Function(String name)? username;
  final bool? isRememberMe;
  final void Function(String onChanged) onChanged;
  final void Function(bool? value) chkOnchanged;
  final TextEditingController passwordController;

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  bool showPassword = true;
  final obscureTextController = ObscuringTextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, __) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                  },
                  child: Column(
                    children: [
                      const Text(
                        "LOGIN",
                        style: TextStyle(
                          fontSize: 16,
                          color:  Palette.textColor1,
                        ),
                      ),
                        Container(
                          height: 5,
                          width: 55,
                          color: Colors.orange,
                        ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                  },
                  child: Column(
                    children: [
                      const Text(
                        'SIGNUP',
                        style: TextStyle(
                          fontSize: 16,
                          color:  Palette.textColor1,
                        ),
                      ),
                        Container(
                          height: 5,
                          width: 55,
                          color: Colors.orange,
                        )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            BuildTextInput(
              maxLines: 1,
              type: TextInputType.emailAddress,
              onChanged: widget.onChanged,
              onSaved: (value) {
                Provider.of<SignInProvider>(context, listen: false)
                    .saveUsername(value!);
              },
              icon: MaterialCommunityIcons.account_outline,
              hintText: "info@example.com",
              isEmail: true,
            ),
    
            /// A TextFormField widget for password input with show/hide functionality.
            /// It uses two TextEditingControllers: [passwordController] for showing the password and
            /// [obscureTextController] for hiding the password. The [showPassword] boolean flag is used to
            /// toggle between the two controllers.
            ///
            /// The [contentPadding], [hintText], [hintStyle], [border], [prefixIcon], and [suffixIcon]
            /// properties are used to customize the appearance of the TextFormField.
            ///
            /// The [suffixIcon] contains an IconButton that toggles the visibility of the password.
            /// When the password is visible, the [suffixIcon] displays an [Icons.visibility] icon.
            /// When the password is hidden, the [suffixIcon] displays an [Icons.visibility_off] icon.
            ///
            /// The [enabledBorder] and [focusedBorder] properties are used to customize the border of the
            /// TextFormField when it is not focused and when it is focused, respectively.
            TextFormField(
              style: const TextStyle(color: Colors.black),
              controller: showPassword
                  ? widget.passwordController
                  : obscureTextController,
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
                      obscureTextController.text =
                          widget.passwordController.text;
                      obscureTextController.selection =
                          TextSelection.collapsed(
                        offset: obscureTextController.text.length,
                      );
                    } else {
                      widget.passwordController.text =
                          obscureTextController.text;
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Row(
                //   children: [
                //     Checkbox(
                //       tristate: false,
                //       value: widget.isRememberMe ?? false,
                //       activeColor: Palette.textColor2,
                //       onChanged: widget.chkOnchanged,
                //     ),
                //     const Text(
                //       "Remember me",
                //       style:
                //           TextStyle(fontSize: 12, color: Palette.textColor1),
                //     ),
                //   ],
                // ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Forgot Password?",
                      style:
                          TextStyle(fontSize: 12, color: Palette.textColor1)),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
