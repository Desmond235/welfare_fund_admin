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

Future<List<TransactionModel>> fetchAllTransactions() async {
  final transactions = await GetTransactionResponse.getTransactions();
  return transactions;
}

List<TransactionModel> filterTransactionsByMonth(
    List<TransactionModel> transactions, DateTime? selectedDate) {
  final dateFormat = DateFormat('yyyy-MM-dd');
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

Future<void> generatePdfReport(
    List<TransactionModel> transactions, DateTime selectedDate) async {
  final pdf = pw.Document();
  final formattedDate = DateFormat.yMMMM();

  final imageAsBytes = await rootBundle.load('assets/images/methodist.png');
  final font =
      pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-Regular.ttf'));

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
          pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text(
            'Transactional Report - ${formattedDate.format(selectedDate)}',
            style: pw.TextStyle(fontSize: 24, font: font),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            'The Methodist Church Ghana',
            style: pw.TextStyle(
              font: font,
              fontSize: 20,
            ),
            textAlign: pw.TextAlign.center,
          ),
          pw.SizedBox(height: 10),
          pw.Image(
            image,
            width: 100,
            height: 100,
            alignment: pw.Alignment.center,
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            'Ebenezer Cathedral- Winneba',
            style: pw.TextStyle(font: font, fontSize: 20),
          ),
          pw.Text(
            'Winneba Ebenezer Methodist cathedral Welfare',
            style: pw.TextStyle(font: font, fontSize: 20),
            textAlign: pw.TextAlign.center
          ),
          pw.SizedBox(height: 20),
          pw.TableHelper.fromTextArray(
              context: context,
              headers: const ['Id', 'Email', 'Amount', 'Date'],
              headerStyle:
                  pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold, fontSize: 17),
              data: [
                ...transactions.map((transaction) {
                  return [
                    transaction.id,
                    transaction.email,
                    transaction.amount,
                    transaction.date,
                  ];
                }),
                ['', '', 'Total: ${totalAmount.toStringAsFixed(2)}', '' ]
              ],
              cellAlignments: {
                0: pw.Alignment.center,
                1: pw.Alignment.center,
                2: pw.Alignment.center,
                3: pw.Alignment.center,
              },
              cellStyle: pw.TextStyle(
                font: font,
                fontSize: 17,
                fontWeight: pw.FontWeight.normal,
              ))
            ]
          )
          
        ];
      },
    ),
  );

  // final file = await pdf.save();
  // final getFile = File(file.toString());

  // if(!context.mounted){
  //   return ;
  // }
  // Navigator.of(context).push(
  //   MaterialPageRoute(
  //     builder: (ctx) =>
  //         PdfViewerScreen(filePath: getFile.path, transactions: transactions),
  //   ),
  // );

  //Save the report to the users device
  final output = await getApplicationCacheDirectory();
  final file = File("${output.path}/report.pdf");
  await file.writeAsBytes(await pdf.save());

  openFile(file.path);
}

void openFile(String filePath) {
  OpenFilex.open(filePath);
}
