import 'package:flutter/material.dart';
import 'package:welfare_fund_admin/core/constants/constants.dart';
import 'package:welfare_fund_admin/core/service/dashboard_service.dart';
import 'package:welfare_fund_admin/features/dashboard/model/gender_model.dart';
import 'package:welfare_fund_admin/features/dashboard/model/total_amount.dart';
import 'package:welfare_fund_admin/features/dashboard/model/total_members_model.dart';
import 'package:welfare_fund_admin/features/transaction/models/transaction_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TotalMembersModel? _totalMembers;
  List<TotalAmountModel> _totalAmount = [];
  List<GenderModel>? _gender;

  TextStyle style = const TextStyle(fontSize: 15);

  Future<void> loadTotalMembers() async {
    final totalMembers = await DashboardService.totalMembers();
    setState(() {
      _totalMembers = totalMembers;
    });
    loadGender();
    loadTotalAmount();
  }

  Future<void>_onRefresh () async {
    await loadTotalMembers();
 }

  Future<void> loadGender() async {
    final gender = await DashboardService.gender();
    setState(() {
      _gender = gender;
    });
  }

  Future<void> loadTotalAmount() async{
    final totalAmount = await DashboardService.totalAmount();
    setState(() {
      _totalAmount = totalAmount;
    });
  }

  @override
  void initState() {
    loadTotalMembers();
    super.initState();
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
                       child: Text('Total Members', style:style ,),
                     ),
                    SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: Card(
                        color: Colors.blue[100],
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
                           child: Text('Males', style: style,),
                         ),
                          Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text('Females',style: style,),
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
                                          ? 'No females yet'
                                          : _gender![1].numberOfMales == 1
                                              ? 'Male'
                                              : '1Males',
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
                              color: Colors.yellow.withOpacity(0.95),
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
                      Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text('Amount Received', style: style,),
                     ),
                     SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: Card(
                        color: Colors.grey[400],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                               '₵ ${_totalAmount[0].totalAmount.toString()}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 30),
                              ),
                              
                              Text(
                                _totalAmount[0].totalAmount == 0
                                    ? 'No Payment received yet'
                                    : 'Received',
                                style: const TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
