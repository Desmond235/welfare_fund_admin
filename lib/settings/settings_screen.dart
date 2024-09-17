import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:welfare_fund_admin/core/components/settings_item.dart';
import 'package:welfare_fund_admin/features/auth/providers/sign_provider.dart';
import 'package:welfare_fund_admin/features/settings/providers/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  _logoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: const Row(
            children: [Icon(Icons.logout), SizedBox(width: 20), Text('Logout')],
          ),
          content: const Text(
            'You are about to log out',
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamedAndRemoveUntil(
                  'auth',
                  (route) => false,
                );
                Provider.of<SignInProvider>(context, listen: false)
                    .removeSigninSate();
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SettingsCard(
                label: 'General',
                children: [
                  SettingsListItem(
                    label: 'Theme',
                    toggle: true,
                    child: AnimatedSwitcher(
                      duration: const Duration(
                        milliseconds: 3000,
                      ),
                      key: ValueKey(_animation),
                      child: Icon(
                        color: Colors.deepPurple.shade300,
                        Provider.of<ThemeProvider>(context, listen: false)
                                    .isDarkMode ||
                                Provider.of<ThemeProvider>(context,
                                        listen: false)
                                    .isDarkTheme
                            ? MaterialCommunityIcons.moon_waning_crescent
                            : Icons.sunny,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SettingsCard(
                label: 'Logout',
                children: [
                  SettingsListItem(
                    onTap: () => _logoutDialog(context),
                    icon: Icons.logout,
                    label: 'Logout',
                    txtColor: Colors.red,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
