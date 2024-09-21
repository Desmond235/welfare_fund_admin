import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:welfare_fund_admin/core/constants/constants.dart';
import 'package:welfare_fund_admin/core/service/dashboard_service.dart';
import 'package:welfare_fund_admin/features/dashboard/model/gender_model.dart';
import 'package:welfare_fund_admin/features/dashboard/model/total_amount.dart';
import 'package:welfare_fund_admin/features/dashboard/model/total_members_model.dart';
import 'package:welfare_fund_admin/features/settings/providers/theme_provider.dart';
import 'package:welfare_fund_admin/features/transaction/models/transaction_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TotalMembersModel? _totalMembers;
  List<TotalAmountModel> _totalAmount = [];
  List<TotalAmountModel> _currentYearData = [];
  int _currentYear = DateTime.now().year;
  List<TotalAmountModel>? data;
  List<GenderModel>? _gender;

  TextStyle style = const TextStyle(fontSize: 15);

  StreamSubscription? streamSubscription;
  bool hasConnection = false;
  DateTime? _date;

  TooltipBehavior? _tooltip;

  void _filterDataForCurrentYear() {
    _currentYearData =
        _totalAmount.where((data) => _date!.year == _currentYear).toList();
    _currentYearData.sort(
      (a, b) => a.month.compareTo(b.month),
    );
  }

  void _updateYear(int year) {
    setState(() {
      _currentYear = year;
      _filterDataForCurrentYear();
    });
  }

  Future<void> loadTotalMembers() async {
    final totalMembers = await DashboardService.totalMembers();
    setState(() {
      _totalMembers = totalMembers;
    });
    loadGender();
    loadTotalAmount();
  }

  Future<void> _onRefresh() async {
    await loadTotalMembers();
  }

  Future<void> loadGender() async {
    final gender = await DashboardService.gender();
    setState(() {
      _gender = gender;
    });
  }

  Future<void> loadTotalAmount() async {
    final totalAmount = await DashboardService.totalAmount();
    setState(() {
      _totalAmount = totalAmount;
    });

    for (final data in _totalAmount) {
      final appendDate = '${data.month}-01';
      setState(() {
        _date = DateTime.parse(appendDate);
      });
    }

    _filterDataForCurrentYear();
  }

  @override
  void initState() {
    loadTotalMembers();
    streamSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      bool isConnected = status == InternetConnectionStatus.connected;
      setState(() {
        hasConnection = isConnected;
      });
    });

    _tooltip = TooltipBehavior(
      enable: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscription!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_totalMembers == null || _gender == null)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else ...[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Total Members',
                          style: style,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: Card(
                          color: context.watch<ThemeProvider>().isDarkMode ||
                                  context.watch<ThemeProvider>().isDarkTheme
                              ? Colors.blue.shade800.withOpacity(0.6)
                              : Colors.blue[100],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _totalMembers!.totalMembers.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 30),
                                ),
                                Text(
                                  _totalMembers!.totalMembers == 0
                                      ? 'No members yet'
                                      : _totalMembers!.totalMembers == 1
                                          ? 'Member'
                                          : 'Members',
                                  style: const TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 10, 8),
                            child: Text(
                              'Males',
                              style: style,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Females',
                              style: style,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 100,
                              child: Card(
                                color: priCol(context).withOpacity(0.7),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        _gender![1].numberOfMales.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 30, color: Colors.white),
                                      ),
                                      Text(
                                        _gender![1].numberOfMales == 0
                                            ? 'No Males yet'
                                            : _gender![1].numberOfMales == 1
                                                ? 'Male'
                                                : 'Males',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: SizedBox(
                              height: 100,
                              child: Card(
                                color: context
                                            .watch<ThemeProvider>()
                                            .isDarkMode ||
                                        context
                                            .watch<ThemeProvider>()
                                            .isDarkTheme
                                    ? Colors.yellow.shade800.withOpacity(0.6)
                                    : Colors.yellow.withOpacity(0.95),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        _gender![0].numberOfFemales.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 30),
                                      ),
                                      Text(
                                        _gender![0].numberOfFemales == 0
                                            ? 'No females yet'
                                            : _gender![0].numberOfFemales == 1
                                                ? 'Female'
                                                : 'Females',
                                        style: const TextStyle(fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(
                      //     'Amount Received',
                      //     style: style,
                      //   ),
                      // ),
                      // SizedBox(
                      //   width: double.infinity,
                      //   height: 150,
                      //   child: Card(
                      //     color: context.watch<ThemeProvider>().isDarkMode ||
                      //             context.watch<ThemeProvider>().isDarkTheme
                      //         ? Colors.grey.shade800.withOpacity(0.7)
                      //         : Colors.grey[400],
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Text(
                      //             '₵ ${_totalAmount[0].totalAmount.toString()}',
                      //             textAlign: TextAlign.center,
                      //             style: const TextStyle(fontSize: 30),
                      //           ),
                      //           Text(
                      //             _totalAmount[0].totalAmount == 0
                      //                 ? 'No Payment received yet'
                      //                 : 'Received',
                      //             style: const TextStyle(fontSize: 18),
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => _updateYear(_currentYear - 1),
                            child: const Text('Previous year'),
                          ),
                          TextButton(
                              onPressed: () => _updateYear(_currentYear + 1),
                              child: const Text('Next Year'))
                        ],
                      ),
                      _currentYearData.isEmpty
                          ? SizedBox(
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/no-data.png',
                                    scale: 5,
                                  ),
                                  const SizedBox(height: 10),
                                  Center(
                                    child: Text(
                                      'No amount received for $_currentYear',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(
                              height: 500,
                              child: SfCartesianChart(
                                title: const ChartTitle(
                                    text: 'Amount Received per Month'),
                                primaryXAxis: const CategoryAxis(),
                                primaryYAxis: NumericAxis(
                                  numberFormat: NumberFormat.compact(),
                                  axisLabelFormatter:
                                      (AxisLabelRenderDetails args) {
                                    return ChartAxisLabel(
                                        '${args.value.toInt()}',
                                        args.textStyle);
                                  },
                                  minimum: 0,
                                  maximum: 10000,
                                  interval: 1000,
                                ),
                                tooltipBehavior: _tooltip,
                                series: <CartesianSeries<TotalAmountModel,
                                    String>>[
                                  BarSeries<TotalAmountModel, String>(
                                    dataSource: _currentYearData,
                                    xValueMapper: (TotalAmountModel data, _) =>
                                        data.month,
                                    yValueMapper: (TotalAmountModel data, _) =>
                                        data.totalAmount,
                                    dataLabelSettings: const DataLabelSettings(
                                        isVisible: true),
                                    name: 'Amount',
                                    color: priCol(context),
                                  )
                                ],
                              ),
                            )
                    ],
                  ],
                ),
              ),
            ),
          ),
        )
        // : Center(
        //     child: Column(
        //       children: [
        //         Lottie.asset(
        //           'assets/no-internet.json',
        //           alignment: Alignment.center,
        //           fit: BoxFit.contain,
        //           width: 230,
        //           height: 230,
        //         ),
        //         const Text(
        //           'Check Internet Connection',
        //           style: TextStyle(fontSize: 16),
        //         )
        //       ],
        //     ),
        //   ),
        );
  }
}
