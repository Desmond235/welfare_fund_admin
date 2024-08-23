import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:welfare_fund_admin/core/service/get_transaction.dart';
import 'package:welfare_fund_admin/features/transaction/models/transaction_model.dart';
import 'package:welfare_fund_admin/features/transaction/screens/pdf_viewer.dart';

Future<List<TransactionModel>> fetchAllTransactions() async {
  final transactions = await GetTransactionResponse.getTransactions();
  return transactions;
}

List<TransactionModel> filterTransactionsByMonth(
    List<TransactionModel> transactions, DateTime? selectedDate) {

  final dateFormat = DateFormat.yMd();
  if (selectedDate == null) return transactions;
  try {
    return transactions.where((transaction) {
      print('transaction date: ${transaction.date}');
    final transactionDate = dateFormat.parse(transaction.date.toString());
    return transactionDate.month == selectedDate.month &&
        transactionDate.year == selectedDate.year;
  }).toList();
  } on FormatException catch (e) {
    print('An error occurred: $e');
    return transactions; 
  }
}

Future<DateTime?> selectedMonth(BuildContext context) async {
  DateTime toDayDate = DateTime.now();
  DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(toDayDate.year - 1),
      lastDate: DateTime(toDayDate.year + 1),
      // initialDate: toDayDate,
      selectableDayPredicate: (day) {
        return day.day == 1;
      });

  return pickedDate;
}

Future<void> generatePdfReport(List<TransactionModel> transactions,
    DateTime selectedDate, BuildContext context) async {
  final pdf = pw.Document();
  final formattedDate = DateFormat.yMMMM();

  final imageAsBytes = await rootBundle.load('assets/images/methodist.png');
  final image = pw.MemoryImage(
    imageAsBytes.buffer.asUint8List(),
  );

  double totalAmount = transactions.fold(
    0,
    (sum, transaction) =>
        sum +
        double.parse(
          transaction.amount.toString(),
        ),
  );
  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(20),
      build: (pw.Context context) {
        return [
          pw.Text(
            'Transactional Report - ${formattedDate.format(selectedDate)}',
            style: const pw.TextStyle(fontSize: 24),
          ),
          pw.SizedBox(height: 10),
          pw.Text('The Methodist Church Ghana'),
          pw.Image(image),
          pw.Text('Ebenezer Cathedral- Winneba'),
          pw.Text('Winneba Ebenezer Methodist cathedral Welfare'),
          pw.SizedBox(height: 15),
          pw.TableHelper.fromTextArray(
              context: context,
              headers: const ['Id', 'Email', 'Amount', 'Date'],
              data: [
                ...transactions.map((transaction) {
                  return [
                    transaction.id,
                    transaction.email,
                    transaction.amount,
                    transaction.date,
                  ];
                }),
                ['', '', 'Total:', totalAmount.toStringAsFixed(2)]
              ],
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerLeft,
                2: pw.Alignment.centerRight,
                3: pw.Alignment.centerLeft,
              },
              cellStyle: pw.TextStyle(
                fontSize: 14,
                fontWeight: pw.FontWeight.normal,
              ))
        ];
      },
    ),
  );

  final file = await pdf.save();
  final getFile = File(file.toString());

  if(!context.mounted){
    return ;
  }
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (ctx) =>
          PdfViewerScreen(filePath: getFile.path, transactions: transactions),
    ),
  );

  //Save the report to the users device
  // final output = await getApplicationCacheDirectory();
  // final file = File("${output.path}/report.pdf");
  // await file.writeAsBytes(await pdf.save());

  // openFile(file.path);
}

void openFile(String filePath) {
  OpenFilex.open(filePath);
}
