import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:welfare_fund_admin/core/constants/constants.dart';
import 'package:welfare_fund_admin/core/controls/data_column.dart';
import 'package:welfare_fund_admin/features/form/models/membership_model.dart';
import 'package:welfare_fund_admin/features/form/service/form_service.dart';
import 'package:welfare_fund_admin/features/home/views/search_members.dart';
import 'package:welfare_fund_admin/features/home/widgets/report.dart';
import 'package:welfare_fund_admin/features/transaction/screens/search_transaction_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentSortIndex = 0;
  bool _isSortAsc = true;

  late Future<List<MembershipModel>> loadMembership;
  MembershipModel? members;

  final _formKey = GlobalKey<FormState>();
  late int userId;

  int _pageSize = 10;

  StreamSubscription? streamSubscription;
  InternetConnectionChecker checkConn = InternetConnectionChecker();
  bool hasConn = false;

  void updateMembers(int id) {
    _formKey.currentState!.save();
  }

  @override
  void initState() {
    super.initState();
    loadMembership = loadMembers();
    streamSubscription = checkConn.onStatusChange.listen((status) {
      bool connStatus = status == InternetConnectionStatus.connected;
      setState(() {
        hasConn = connStatus;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscription!.cancel();
  }

  Future<List<MembershipModel>> loadMembers() async {
    final membership = await FormServiceResponse.getMembershipDetails();
    return membership;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SearchMembersScreen(),
                ),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body:  SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Center(
                // Ensures the DataTable is centered
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<MembershipModel>>(
                    future: loadMembership,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No data available');
                      }

                      final members = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: priCol(context),
                                ),
                                onPressed: () {
                                  setState(() {
                                    loadMembership = loadMembers();
                                  });
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text(
                                    'Refresh',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              IconButton(
                                tooltip: 'Download report',
                                onPressed: () =>
                                    generatePdfReportForMembers(members, context),
                                icon: const Icon(
                                  Icons.download,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          Theme(
                            data: theme.copyWith(
                              iconTheme:
                                  theme.iconTheme.copyWith(color: Colors.white),
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Form(
                                  key: _formKey,
                                  child: PaginatedDataTable(
                                    source: _DataSource(members: members),
                                    rowsPerPage: _pageSize,
                                    availableRowsPerPage: const [10, 15, 25],
                                    onRowsPerPageChanged: (value) {
                                      setState(() {
                                        _pageSize = value!;
                                      });
                                    },
                                    
                                    headingRowColor:
                                        WidgetStateProperty.resolveWith(
                                            (states) => priCol(context)),
                                    showCheckboxColumn: true,
                                    sortColumnIndex: _currentSortIndex,
                                    sortAscending: _isSortAsc,
                                    columns: getDataColumns(members),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            )
          // : Center(
          //   child: Column(
          //     children: [
          //       Lottie.asset(
          //           'assets/no-internet.json',
          //           alignment: Alignment.center,
          //            fit: BoxFit.contain,
          //           width: 230,
          //           height: 230,
          //         ),
          //         const Text('Check Internet Connection', style: TextStyle(
          //           fontSize: 16
          //         ),)
          //     ],
          //   ),
          // ),
    );
  }

  List<DataColumn> getDataColumns(List<MembershipModel> members) {
    return [
      DataColumn(
        onSort: (columnIndex, value) {
          setState(() {
            _currentSortIndex = columnIndex;
            if (_isSortAsc) {
              members.sort((a, b) => b.id.compareTo(a.id));
            } else {
              members.sort((a, b) => a.id.compareTo(b.id));
            }
            _isSortAsc = !_isSortAsc;
          });
        },
        label: const Text(
          'Id',
          style: TextStyle(color: Colors.white),
        ),
      ),
      DataColumn(
        onSort: (columnIndex, value) {
          setState(() {
            _currentSortIndex = columnIndex;
            if (_isSortAsc) {
              members.sort((a, b) => b.full_name.compareTo(a.full_name));
            } else {
              members.sort((a, b) => a.full_name.compareTo(b.full_name));
            }
            _isSortAsc = !_isSortAsc;
          });
        },
        label: const Text(
          'Full Name',
          style: TextStyle(color: Colors.white),
        ),
      ),
      DataColumn(
        onSort: (columnIndex, value) {
          setState(() {
            _currentSortIndex = columnIndex;
            if (_isSortAsc) {
              members.sort((a, b) => b.date_of_birth.compareTo(a.date_of_birth));
            } else {
              members.sort((a, b) => a.date_of_birth.compareTo(b.date_of_birth));
            }
            _isSortAsc = !_isSortAsc;
          });
        },
        label: const Text(
          'Date of Birth',
          style: TextStyle(color: Colors.white),
        ),
      ),
      ...getColumns()
    ];
  }
}

class _DataSource extends DataTableSource {
  List<MembershipModel> members;
  _DataSource({required this.members});
  @override
  DataRow? getRow(int index) {
    if (index >= members.length) {
      return null;
    }
    final item = members[index];
    return DataRow(cells: cells(item: item));
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => members.length;

  @override
  int get selectedRowCount => 0;
}

List<DataCell> cells({required MembershipModel item}) {
  return [
    DataCell(Text(item.id.toString())),
    DataCell(Text(item.full_name)),
    DataCell(Text(item.date_of_birth)),
    DataCell(Text(item.date_of_registration)),
    DataCell(Text(item.contact.toString())),
    DataCell(Text(item.house_number)),
    DataCell(Text(item.place_of_abode)),
    DataCell(Text(item.land_mark)),
    DataCell(Text(item.home_town)),
    DataCell(Text(item.region)),
    DataCell(Text(item.marital_status)),
    DataCell(Text(item.name_of_spouse ?? 'N/A')),
    DataCell(Text(item.life_status ?? "N/A")),
    DataCell(Text(item.occupation)),
    DataCell(Text(item.fathers_name)),
    DataCell(Text(item.father_life_status)),
    DataCell(Text(item.mothers_name)),
    DataCell(Text(item.mother_life_status)),
    DataCell(Text(item.next_of_kin)),
    DataCell(Text(item.next_of_kin_contact.toString())),
    DataCell(Text(item.class_leader)),
    DataCell(Text(item.class_leader_contact.toString())),
    DataCell(Text(item.organization_of_member ?? 'N/A')),
    DataCell(Text(item.org_leader_contact.toString()))
  ];
}
