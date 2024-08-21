import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:welfare_fund_admin/core/base/main/main_page_provider.dart';
import 'package:welfare_fund_admin/core/components/nav_item.dart';
import 'package:welfare_fund_admin/features/settings/providers/theme_provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;

  @override
  void initState() {
    selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      indicatorColor: Theme.of(context).colorScheme.primary,
      selectedIndex: context.watch<MainPageProvider>().currentPage,
      height: 60,
      surfaceTintColor: Colors.white,
      backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode ||
              Provider.of<ThemeProvider>(context).isDarkTheme
          ? Colors.black26
          : Colors.white,
      destinations: const [
        NavItem(icon: MaterialCommunityIcons.home, index: 0),
        NavItem(icon: Icons.payment, index: 1),
        NavItem(icon: Icons.attach_money,index: 2)
      ],
    );
  }
}
