// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
import 'package:welfare_fund_admin/core/constants/constants.dart';
import 'package:welfare_fund_admin/core/controls/snackbar.dart';
import 'package:welfare_fund_admin/core/service/get_transaction.dart';
import 'package:welfare_fund_admin/features/transaction/models/transaction_model.dart';
import 'package:welfare_fund_admin/features/transaction/screens/search_transaction_screen.dart';
import 'package:welfare_fund_admin/features/transaction/widgets/report.dart';
import 'package:intl/intl.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final bool _isEditMode = false;

  int _currentSortIndex = 0;
  bool _isSortAsc = true;

  late Future<List<TransactionModel>> loadMembership;
  final _formKey = GlobalKey<FormState>();

  int _currentPage = 1;
  int _rowSize = 10;
  DateTime? _selectedDate;

  final formattedDate = DateFormat.yMMMM();

  StreamSubscription? streamSubscription;
  bool hasConnection = false;

  @override
  void initState() {
    super.initState();
    loadMembership = loadMembers();
    streamSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      hasConnection = status == InternetConnectionStatus.connected;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscription!.cancel();
  }

  Future<List<TransactionModel>> loadMembers() async {
    final membership = await GetTransactionResponse.getTransactions();
    return membership;
  }

  void selectedDate() async {
    final chosenDate = await selectedMonth(context);
    if (chosenDate != null) {
      setState(() {
        _selectedDate = chosenDate;
      });
    }
  }

  void downloadReport(List<TransactionModel> members, DateTime? selectedDate) {
    if (selectedDate != null) {
      final filteredTransactions =
          filterTransactionsByMonth(members, selectedDate);
      generatePdfReport(filteredTransactions, selectedDate, context);
    } else {
      snackBar(context, 'Please select a month first');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: [
          IconButton(
            tooltip: 'Search ',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SearchTransactionScreen(),
                ),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<TransactionModel>>(
          future: loadMembership,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/no_cash.png', scale: 10),
                  const SizedBox(height: 10),
                  const Text(
                    'No Transactions made yet',
                    style: TextStyle(fontSize: 17),
                  )
                ],
              );
            }

            final members = snapshot.data!;
            return SingleChildScrollView(
              // scrollDirection: Axis.horizontal,
              child: Column(
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
                          print(members.length);
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
                      OutlinedButton(
                        onPressed: selectedDate,
                        child: Text(
                          _selectedDate == null
                              ? 'Select Month'
                              : formattedDate.format(_selectedDate!),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Download report',
                        onPressed: () => downloadReport(members, _selectedDate),
                        icon: const Icon(Icons.download, size: 30),
                      )
                    ],
                  ),
                  Theme(
                    data: theme.copyWith(
                      iconTheme: theme.iconTheme.copyWith(color: Colors.white),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      // height: MediaQuery.of(context).size.height * 0.7,
                      // width: double.infinity,
                      child: Form(
                        key: _formKey,
                        child: PaginatedDataTable(
                          rowsPerPage: _rowSize,
                          availableRowsPerPage: const [10, 20, 30],
                          // initialFirstRowIndex: _currentPage,
                          onPageChanged: (value) {
                            _currentPage = value;
                          },
                          onRowsPerPageChanged: (value) {
                            setState(() {
                              _rowSize = value!;
                            });
                          },
                          source: _DataSource(transactions: members),
                          headingRowColor: WidgetStateProperty.resolveWith(
                              (states) => priCol(context)),
                          showCheckboxColumn: true,
                          sortColumnIndex: _currentSortIndex,
                          sortAscending: _isSortAsc,
                          columns: getDataColumns(members),
                          // rows: [
                          //   for (var item in members) getRows(item),
                          // ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      // :  Center(
      //       child: Column(
      //         children: [
      //           Lottie.asset(
      //               'assets/no-internet.json',

      //               alignment: Alignment.center,
      //                fit: BoxFit.contain,
      //               width: 230,
      //               height: 230,
      //             ),
      //             const Text('Check Internet Connection', style: TextStyle(
      //               fontSize: 16
      //             ),)
      //         ],
      //       ),
      //     ),
      floatingActionButton: _isEditMode
          ? FloatingActionButton(
              onPressed: () {
                // print(members!.id);
                // // print(members!.full_name);
                // updateMembers(members!.id);
              },
              backgroundColor: priCol(context),
              child: const Icon(
                Icons.save,
                color: Colors.white,
              ),
            )
          : null,
    );
  }

  List<DataColumn> getDataColumns(List<TransactionModel> members) {
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
              members.sort((a, b) => b.firstName.compareTo(a.firstName));
            } else {
              members.sort((a, b) => a.firstName.compareTo(b.firstName));
            }
            _isSortAsc = !_isSortAsc;
          });
        },
        label: const Text(
          'First  name',
          style: TextStyle(color: Colors.white),
        ),
      ),
      DataColumn(
        onSort: (columnIndex, value) {
          setState(() {
            _currentSortIndex = columnIndex;
            if (_isSortAsc) {
              members.sort((a, b) => b.lastName.compareTo(a.lastName));
            } else {
              members.sort((a, b) => a.lastName.compareTo(b.lastName));
            }
            _isSortAsc = !_isSortAsc;
          });
        },
        label: const Text(
          'Lastname  name',
          style: TextStyle(color: Colors.white),
        ),
      ),
      DataColumn(
        onSort: (columnIndex, value) {
          setState(() {
            _currentSortIndex = columnIndex;
            if (_isSortAsc) {
              members.sort((a, b) => b.email.compareTo(a.email));
            } else {
              members.sort((a, b) => a.email.compareTo(b.email));
            }
            _isSortAsc = !_isSortAsc;
          });
        },
        label: const Text(
          'Email',
          style: TextStyle(color: Colors.white),
        ),
      ),
      DataColumn(
        onSort: (columnIndex, value) {
          setState(() {
            _currentSortIndex = columnIndex;
            if (_isSortAsc) {
              members.sort((a, b) => b.amount.compareTo(a.amount));
            } else {
              members.sort((a, b) => a.amount.compareTo(b.amount));
            }
            _isSortAsc = !_isSortAsc;
          });
        },
        label: const Text(
          'Amount',
          style: TextStyle(color: Colors.white),
        ),
      ),
      DataColumn(
        onSort: (columnIndex, value) {
          setState(() {
            _currentSortIndex = columnIndex;
            if (_isSortAsc) {
              members.sort((a, b) => b.date.compareTo(a.date));
            } else {
              members.sort((a, b) => a.date.compareTo(b.date));
            }
            _isSortAsc = !_isSortAsc;
          });
        },
        label: const Text(
          "Date",
          style: TextStyle(color: Colors.white),
        ),
      )
    ];
  }
}

class _DataSource extends DataTableSource {
  final List<TransactionModel> transactions;

  _DataSource({required this.transactions});

  @override
  DataRow? getRow(int index) {
    if (index >= transactions.length) {
      return null;
    }

    final item = transactions[index];
    return DataRow(cells: [
      DataCell(Text(item.id.toString())),
      DataCell(Text(item.firstName.toString())),
      DataCell(Text(item.lastName.toString())),
      DataCell(Text(item.email.toString())),
      DataCell(Text(item.amount.toString())),
      DataCell(Text(item.date.toString()))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => transactions.length;

  @override
  int get selectedRowCount => 0;
}
