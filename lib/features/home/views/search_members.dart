import 'package:flutter/material.dart';
import 'package:welfare_fund_admin/core/controls/data_column.dart';
import 'package:welfare_fund_admin/core/service/search_members.dart';
import 'package:welfare_fund_admin/features/form/models/membership_model.dart';

class SearchMembersScreen extends StatefulWidget {
  const SearchMembersScreen({super.key});

  @override
  State<SearchMembersScreen> createState() => _SearchMembersScreenState();
}

class _SearchMembersScreenState extends State<SearchMembersScreen> {
  final _searchController = TextEditingController();
  List<MembershipModel> _members = [];
  bool _isLoading = false;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  void _onSearchChanged() {
    if (_searchController.text.isNotEmpty) {
      _performSearch();
    } else {
      setState(() {
        _members.clear();
      });
    }
  }

  void _performSearch() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final results = await SearchMembersService.getTransactions(
        context,
        searchQuery: _searchController.text,
      );

      setState(() {
        _members = results;
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
        title: const Text('Search Members'),
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
                : _members.isEmpty
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
                            source: _DataSource(members: _members),
                            columns: [
                              const DataColumn(
                                label: Text(
                                  'Id',
                                ),
                              ),
                              const DataColumn(
                                label: Text(
                                  'Full Name',
                          
                                ),
                              ),
                              const DataColumn(
                                label: Text(
                                  'Date of Birth',
                                ),
                              ),
                              ...getColumns()
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
  List<MembershipModel> members;
  _DataSource({required this.members});

  @override
  DataRow? getRow(int index) {
    if (index >= members.length) {
      return null;
    }

    final item = members[index];
    return DataRow(
      cells: [
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
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => members.length;

  @override
  int get selectedRowCount => 0;
}
