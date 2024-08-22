
// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:welfare_fund_admin/core/components/data_row.dart';
import 'package:welfare_fund_admin/core/constants/constants.dart';
import 'package:welfare_fund_admin/core/controls/data_column.dart';
import 'package:welfare_fund_admin/core/service/get_transaction.dart';
import 'package:welfare_fund_admin/features/form/models/membership_model.dart';
import 'package:welfare_fund_admin/features/form/service/form_service.dart';
import 'package:welfare_fund_admin/features/transaction/models/transaction_model.dart';


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

  @override
  void initState() {
    super.initState();
    loadMembership = loadMembers();
  }

  Future<List<TransactionModel>> loadMembers() async {
    final membership =
        await GetTransactionResponse.getTransactions();
    return  membership;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          // Ensures the DataTable is centered
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<List<TransactionModel>>(
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
                    Theme(
                      data: theme.copyWith(
                        iconTheme:
                            theme.iconTheme.copyWith(color: Colors.white),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Form(
                              key: _formKey,
                              child: DataTable(
                                showBottomBorder: true,
                                headingRowColor:
                                    WidgetStateProperty.resolveWith(
                                        (states) => priCol(context)),
                                showCheckboxColumn: true,
                                sortColumnIndex: _currentSortIndex,
                                sortAscending: _isSortAsc,
                                columns: getDataColumns(members),
                                rows: [
                                  for (var item in members) getRows(item),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  
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
                      
                  ],
                );
              },
            ),
          ),
        ),
      ),
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

  DataRow getRows(TransactionModel item) {
    return DataRow(
      cells: [
        createTitleCell(item.id.toString(), _isEditMode,
            onSaved: (value) {
          fullNameController = value!;
          print(fullNameController);
        }),
        createTitleCell(item.email.toString(), _isEditMode,
            onSaved: (value) {
          dateOfBirthController = value!;
          print(dateOfBirthController);
        }),
        createTitleCell(item.amount.toString(), _isEditMode,
            onSaved: (value) {
          dateOfRegistrationController = value!;
        }),
        createTitleCell(item.date.toString(), _isEditMode, onSaved: (value) {
          contactController = value!;
        }),
      ],
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
          'Full Name',
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
          'Date of Birth',
          style: TextStyle(color: Colors.white),
        ),
      ),
      ...getColumns()
    ];
  }
 }
