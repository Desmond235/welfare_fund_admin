import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:welfare_fund_admin/core/controls/snackbar.dart';
import 'package:welfare_fund_admin/features/transaction/models/transaction_model.dart';
import 'package:http/http.dart' as http;

class SearchTransactionService {
  static Future<List<TransactionModel>> getTransactions(
     BuildContext context, {String searchQuery = ''}) async {
    const searchUrl = 'http://10.0.2.2:3000/api/admin';

    final response = await http.get(
      Uri.parse('$searchUrl/search-transactions?search=$searchQuery'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData
          .map((json) => TransactionModel.fromJson(json))
          .toList();
    } else{
      if(context.mounted){
        snackBar(context, 'Failed to load transactions');
      }
      return [];
    }
  }
}
