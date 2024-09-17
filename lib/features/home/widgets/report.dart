import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:welfare_fund_admin/core/constants/constants.dart';
import 'package:welfare_fund_admin/features/form/models/membership_model.dart';
import 'package:welfare_fund_admin/features/form/service/form_service.dart';

Future<List<MembershipModel>> fetchAllMembers() async {
  final members = await FormServiceResponse.getMembershipDetails();
  return members;
}

Future<void> generatePdfReportForMembers(
    List<MembershipModel> members, BuildContext context) async {
  final pdf = pw.Document();

  final imageAsBytes = await rootBundle.load('assets/images/methodist.png');
  final font =
      pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-Regular.ttf'));

  final image = pw.MemoryImage(
    imageAsBytes.buffer.asUint8List(),
  );

  pdf.addPage(
    pw.MultiPage(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(20),
      build: (pw.Context context) {
        return [
          pw.Text(
            'Members - Report',
            style: pw.TextStyle(
                fontSize: 24, font: font, fontWeight: pw.FontWeight.bold),
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
          pw.Text('Winneba Ebenezer Methodist cathedral Welfare',
              style: pw.TextStyle(font: font, fontSize: 20),
              textAlign: pw.TextAlign.center),
          pw.SizedBox(height: 20),
          pw.TableHelper.fromTextArray(
            context: context,
            headers: const [
              'Id',
              'Full Name',
              'Date of Registration',
              'Contact',
              'Place of Abode',
              'Landmark',
              'Marital Status',
            ],
            headerStyle: pw.TextStyle(
                font: font, fontWeight: pw.FontWeight.bold, fontSize: 17),
            data: [
              ...members.map((member) {
                return [
                  member.id,
                  member.full_name,
                  member.date_of_registration,
                  member.contact,
                  member.place_of_abode,
                  member.land_mark,
                  member.marital_status,
                ];
              }),
            ],
            cellAlignments: {
              0: pw.Alignment.center,
              1: pw.Alignment.center,
              2: pw.Alignment.center,
              3: pw.Alignment.center,
              4: pw.Alignment.center,
              5: pw.Alignment.center,
              6: pw.Alignment.center,
            },
            cellStyle: pw.TextStyle(
              font: font,
              fontSize: 17,
              fontWeight: pw.FontWeight.normal,
            ),
          ),
          pw.SizedBox(height: 40),
          pw.TableHelper.fromTextArray(
            context: context,
            headers: const [
              'Occupation',
              'Father\'s Name',
              'Father\'s Life Status',
              'Mother\'s Name',
              'Mother\'s Life Status',
              'Next of Kin',
              'Class Leader',
            ],
            headerStyle: pw.TextStyle(
                font: font, fontWeight: pw.FontWeight.bold, fontSize: 17),
            data: [
              ...members.map((member) {
                return [
                  member.occupation,
                  member.fathers_name,
                  member.father_life_status,
                  member.mothers_name,
                  member.mother_life_status,
                  member.next_of_kin,
                  member.class_leader,
                ];
              }),
            ],
            cellAlignments: {
              7: pw.Alignment.center,
              8: pw.Alignment.center,
              9: pw.Alignment.center,
              10: pw.Alignment.center,
              11: pw.Alignment.center,
              12: pw.Alignment.center,
              13: pw.Alignment.center,
            },
            cellStyle: pw.TextStyle(
              font: font,
              fontSize: 17,
              fontWeight: pw.FontWeight.normal,
            ),
          ),
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
  final output = await getApplicationDocumentsDirectory();
  final file = File("${output.path}/report.pdf");
  await file.writeAsBytes(await pdf.save());
  if (await file.exists()) {
    if (context.mounted) showDialogue(context, output, file);
  }
}

void openFile(String filePath) {
  OpenFilex.open(filePath);
}

Future<void> downloading(BuildContext context) {
  return showDialog(
    context: context,
    useSafeArea: true,
    barrierDismissible: false,
    builder: (context) {
      return const AlertDialog(
        content: Column(
          children: [
            Center(
              child: CircularProgressIndicator(),
            ),
             SizedBox(height: 10),
             Text('File is downloading...'),
          ],
        ),
      );
    },
  );
}

Future<void> showDialogue(BuildContext context, Directory report, File file) {
  return showDialog(
    context: context,
    useSafeArea: true,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text('Report'),
        actionsAlignment: MainAxisAlignment.center,
        content: Text(
          'pdf saved to ${report.path} ',
          style: const TextStyle(fontSize: 15),
        ),
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.all(20),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Dismiss',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(width: 5),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                backgroundColor: priCol(context),
                foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(context);
              openFile(file.path);
            },
            child: const Text(
              'Open File',
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      );
    },
  );
}
