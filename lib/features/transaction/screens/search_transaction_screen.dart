import 'package:flutter/material.dart';
import 'package:welfare_fund_admin/core/service/search_transaction_service.dart';
import 'package:welfare_fund_admin/features/transaction/models/transaction_model.dart';

class SearchTransactionScreen extends StatefulWidget {
  const SearchTransactionScreen({super.key});

  @override
  State<SearchTransactionScreen> createState() =>
      _SearchTransactionScreenState();
}

class _SearchTransactionScreenState extends State<SearchTransactionScreen> {
  final _searchController = TextEditingController();
  List<TransactionModel> _transactions = [];
  bool _isLoading = false;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  void _onSearchChanged() {
    if (_searchController.text.isNotEmpty) {
      _performSearch();
    } else {
      setState(() {
        _transactions.clear();
      });
    }
  }

  void _performSearch() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final results = await SearchTransactionService.getTransactions(
        context,
        searchQuery: _searchController.text,
      );

      setState(() {
        _transactions = results;
        _isLoading = false;
      });
    } on Exception catch (e) {
      setState(() {
        _isLoading = false;
      });

      // Show error message to user
      if (!mounted) return;
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(
                  'An error occurred while searching transactions: ${e.toString()}'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    }
  }

  @override
  void initState() {
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _searchController.removeListener(_onSearchChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Transaction'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              autofocus: true,
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _transactions.isEmpty
                    ? Column(
                      children: [
                        Image.asset('assets/images/PPC.png', scale: 6,),
                        const Center(
                            child: Text('No results found', style: TextStyle(fontSize: 18),),
                          ),
                      ],
                    )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: PaginatedDataTable(
                            rowsPerPage: _rowsPerPage,
                            header: const Text('Search Results'),
                            availableRowsPerPage: const [10, 20, 40],
                            onRowsPerPageChanged: (value) {
                              setState(() {
                                _rowsPerPage = value!;
                              });
                            },

                            source: _DataSource(transactions: _transactions),
                            columns: const [
                              DataColumn(label: Text('ID')),
                              DataColumn(label: Text('First name')),
                              DataColumn(label: Text('Last name')),
                              DataColumn(label: Text('Amount')),
                              DataColumn(label: Text('Email')),
                              DataColumn(label: Text('Date')),
                            ],
                          ),
                        ),
                      ),
          )
        ],
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  List<TransactionModel> transactions;
  _DataSource({required this.transactions});

  @override
  DataRow? getRow(int index) {
    if (index >= transactions.length) {
      return null;
    }

    final item = transactions[index];
    return DataRow(
      cells: [
        DataCell(Text(item.id.toString())),
        DataCell(Text(item.firstName.toString())),
        DataCell(Text(item.lastName.toString())),
        DataCell(Text(item.amount.toString())),
        DataCell(Text(item.email.toString())),
        DataCell(Text(item.date.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => transactions.length;

  @override
  int get selectedRowCount => 0;
}
