import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
// import 'package:http/http.dart' as http;
import 'package:welfare_fund_admin/core/components/dialog_box.dart';
import 'package:welfare_fund_admin/core/constants/constants.dart';
import 'package:welfare_fund_admin/core/constants/palette.dart';
import 'package:welfare_fund_admin/core/service/verify_login.dart';
import 'package:welfare_fund_admin/features/auth/providers/change_credentials_provider.dart';
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
  bool? isRememberMe;
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final bool _isSending = true;
  late ChangeCredentialsProvider credentialsState;

  @override
  void initState() {
    super.initState();
     credentialsState =
              Provider.of<ChangeCredentialsProvider>(context, listen: false);
              
          credentialsState.getCredentials();
  }

  login() {
    VerifyLogin.post(
      usernameController.text,
      passwordController.text,
      context,
      credentialsState
    );
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    usernameController.dispose();
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
                                        RichText(
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
                            onTap: (){
                              login();
                              // credentialsState.setIsChangeCredentials(false);
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
