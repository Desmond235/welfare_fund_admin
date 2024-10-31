import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:welfare_fund_admin/core/base/main/main_screen.dart';
import 'package:welfare_fund_admin/core/constants/constants.dart';
import 'package:welfare_fund_admin/core/theme/dark_theme.dart';
import 'package:welfare_fund_admin/features/auth/providers/sign_provider.dart';
import 'package:welfare_fund_admin/features/auth/views/auth.dart';
import 'package:welfare_fund_admin/features/auth/views/change_credentials.dart';
import 'package:welfare_fund_admin/features/settings/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // systemNavBarColor;

  await dotenv.load(fileName: '.env');
  runApp(MultiProvider(
    providers: multiProviders,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeProvider>(context);
    themeState.getDarkTheme();

    final signinState = context.watch<SignInProvider>();
    signinState.getSigninState();

    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      darkTheme: darkMode,
      themeMode: themeState.isDarkTheme
          ? ThemeMode.dark
          : !themeState.isDarkTheme
              ? ThemeMode.light
              : ThemeMode.system,
      theme: Provider.of<ThemeProvider>(context).themeData,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const ChangeCredentials(),
      // home: signinState.isSignin ? const MainScreen() : const AuthScreen(),
      routes: routes,
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
