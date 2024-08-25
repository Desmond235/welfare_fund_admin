
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:welfare_fund_admin/core/base/main/main_page_provider.dart';
import 'package:welfare_fund_admin/core/base/main/main_screen.dart';
import 'package:welfare_fund_admin/core/constants/palette.dart';
import 'package:welfare_fund_admin/core/service/verify_login.dart';
import 'package:welfare_fund_admin/features/auth/providers/change_credentials_provider.dart';
import 'package:welfare_fund_admin/features/auth/views/auth.dart';
import 'package:welfare_fund_admin/features/auth/views/chang_password.dart';
import 'package:welfare_fund_admin/features/auth/views/change_credentials.dart';
import 'package:welfare_fund_admin/features/auth/views/email_screen.dart';
import 'package:welfare_fund_admin/features/auth/views/verify_email.dart';
import 'package:welfare_fund_admin/features/home/views/home_screen.dart';
import 'package:welfare_fund_admin/features/settings/providers/theme_provider.dart';
import 'package:welfare_fund_admin/features/transaction/screens/transaction_screen.dart';

// ignore: non_constant_identifier_names
final KMainPages = [
  const HomeScreen(),
  const TransactionScreen(),
];

Color priCol(BuildContext context) {
  return Theme.of(context).colorScheme.primary;
}

final Future<SharedPreferences> sharedPrefs = SharedPreferences.getInstance();

List<SingleChildWidget> multiProviders = [
  
  ChangeNotifierProvider(create: (context) => ThemeProvider()),
  ChangeNotifierProvider(create: (context) => MainPageProvider()),
  ChangeNotifierProvider(create: (context) => ChangeCredentialsProvider()),
  
];

final systemNavBarColor = SystemChrome.setSystemUIOverlayStyle(
  const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark
    // systemNavigationBarColor: Palette.backgroundColor,
    // systemNavigationBarIconBrightness: Brightness.dark,
    // systemNavigationBarDividerColor: Colors.transparent
  ),
);

const systemUiOverlayStyle = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
    systemNavigationBarColor: Palette.backgroundColor,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.transparent);

SystemUiOverlayStyle mainSystemUiOverlayStyle(BuildContext context) {
  final darkTheme =
      Provider.of<ThemeProvider>(context, listen: false).isDarkTheme;
  final darkMode =
      Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
  return SystemUiOverlayStyle(
      systemNavigationBarColor:
          darkMode || darkTheme ? Colors.black.withOpacity(0.85) : Colors.white,
      systemNavigationBarIconBrightness:
          darkMode || darkTheme ? Brightness.light : Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent);
}

Map<String, Widget Function(BuildContext)> routes = {
  "changeCredentials": (context) => const ChangeCredentials(),
  "main": (context) => const MainScreen(),
  'otp': (context) => const VerifyEmail(),
  'email':(context) => const EmailScreen(),
  'password': (context) => const ChangePasswordScreen(),
  'auth': (context) => const AuthScreen(),
  
};

List<Widget> kOnboardPage = [
  
 ];


 
String fullNameController = '';
String dateOfBirthController = '';
String dateOfRegistrationController = '';
String contactController = '';
String houseNumberController = '';
String placeOfAbodeController = '';
String landMarkController = '';
String homeTownController = '';
String regionController = '';
String maritalStatusController = '';
String nameOfSpouseController = '';
String lifeStatusController = '';
String occupationController = '';
String fatherNameController = '';
String fatherLifeStatusController = '';
String motherNameController = '';
String motherLifeStatusController = '';
String nextOfKinController = '';
String nextOfKinContactController = '';
String classLeaderController = '';
String classLeaderContactController = '';
String organizationOfMemberController = '';
String orgLeaderContactController = '';


 


 
