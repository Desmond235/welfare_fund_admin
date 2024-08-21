
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:welfare_fund_admin/core/constants/palette.dart';
import 'package:welfare_fund_admin/features/auth/views/change_credentials.dart';
import 'package:welfare_fund_admin/features/home/views/home_screen.dart';
import 'package:welfare_fund_admin/features/settings/providers/theme_provider.dart';
import 'package:welfare_fund_admin/features/transaction/screens/transaction_screen.dart';

final KMainPages = [];

Color priCol(BuildContext context) {
  return Theme.of(context).colorScheme.primary;
}

final Future<SharedPreferences> sharedPrefs = SharedPreferences.getInstance();

List<SingleChildWidget> multiProviders = [
  
  ChangeNotifierProvider(create: (context) => ThemeProvider()),
  
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
  "changeCredentials": (context) => const ChangeCredentials()
  
};

List<Widget> kOnboardPage = [
  const HomeScreen(),
  const TransactionScreen(),
 ];

 


 
