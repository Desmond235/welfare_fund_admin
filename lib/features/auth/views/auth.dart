import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:http/http.dart' as http;
import 'package:welfare_fund_admin/core/components/dialog_box.dart';
import 'package:welfare_fund_admin/core/constants/constants.dart';
import 'package:welfare_fund_admin/core/constants/palette.dart';
import 'package:welfare_fund_admin/features/widgets/signin/build_signin.dart';
import 'package:welfare_fund_admin/features/widgets/signin/submit_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  File? pickedImageFile;
  String? username;
  bool? isRememberMe;
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  bool _isSending = true;

  http.Response? response;

 
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
  }
// this function allows users to pick an image
// and enter the enter their registration credentials
// if the user does not pick an image, he or she will be prompted to pick an image
// if the user enters a wrong or does or does not enter any information, the user will be prompted to do so

  post() {}
 
  
  void addCredentials() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (pickedImageFile == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please pick an image"),
      ));
    }

    _formKey.currentState!.save();


    // Navigator.of(context).pushReplacementNamed('main');
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (value, result) {
        dialogBox(context);
      },
      child: Scaffold(
        backgroundColor: Palette.backgroundColor,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: systemUiOverlayStyle,
          child: SingleChildScrollView(
            child: KeyboardDismissOnTap(
              child: Consumer(
                builder: (context, value, child) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 0.96,
                    child: Form(
                      key: _formKey,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              child: Container(
                                height: 355,
                                // background image
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/logo.png',
                                      ),
                                      fit: BoxFit.cover),
                                ),
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(top: 40, left: 20),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.8),
                                  child: SafeArea(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // color: priCol(context).withOpacity(0.4),
                                          child: RichText(
                                            text: TextSpan(
                                              text: "Welcome to",
                                              style: TextStyle(
                                                color: Colors.yellow[700],
                                                fontSize: width < 600 ? 20 : 25,
                                                letterSpacing: 2,
                                              ),
                                              children: [
                                                TextSpan(
                                                    text: " Welfare Fund,",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.yellow[600],
                                                        fontSize: width < 600
                                                            ? 20
                                                            : 25,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                       
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SubmitButton(
                            isSending: _isSending,
                            isShadow: true,
                            onTap: () {},
                          ),
                          // this adds a submit button
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.bounceInOut,
                            top: 230,
                            child: AnimatedContainer(
                              duration: const Duration(microseconds: 700),
                              curve: Curves.bounceInOut,
                              width: MediaQuery.of(context).size.width - 40,
                              height: 260,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                    SignInWidget(
                                      // FIXME: getTextBefore on inactive input connection issue
                                      usernameController: usernameController,
                                      passwordController: passwordController,
                                      isRememberMe: isRememberMe,
                                      onChanged: (value) async {
                                        setState(() {
                                          username = value;
                                        });
                                      },
                                      chkOnchanged: (value) async {
                                        setState(() {
                                          isRememberMe = value!;
                                        });
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ),
                          SubmitButton(
                            isSending: _isSending,
                            onTap: () async {
                            },
                            isShadow: false,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
