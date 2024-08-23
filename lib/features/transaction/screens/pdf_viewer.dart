import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:welfare_fund_admin/features/transaction/models/transaction_model.dart';

class PdfViewerScreen extends StatelessWidget {
  const PdfViewerScreen(
      {super.key, required this.filePath, required this.transactions});
  final String filePath;
  final List<TransactionModel> transactions;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview report'), actions: [
        IconButton(icon: const Icon(Icons.download), onPressed: () {})
      ]),
      body: Center(
        child: PdfDocumentLoader.openFile(
          filePath,
          documentBuilder: (context, pdfDocument, pageCount) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    return PdfPageView(
                      pageNumber: index + 1,
                      pdfDocument: pdfDocument ,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
