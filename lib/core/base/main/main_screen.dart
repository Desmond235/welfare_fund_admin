import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:welfare_fund_admin/core/base/main/main_page_provider.dart';
import 'package:welfare_fund_admin/core/components/bottom_nav_bar.dart';
import 'package:welfare_fund_admin/core/constants/constants.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageProvider>(builder: (_, pageState, __) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: mainSystemUiOverlayStyle(context),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              pageState.currentPage == 0 ? "Home" : "Transactions",
            ),
          ),
          body: KMainPages[pageState.currentPage],

          bottomNavigationBar: const BottomNavBar(),
        ),
      );
    });
  }
}
