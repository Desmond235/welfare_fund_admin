import 'package:church_clique/core/components/dialog_box.dart';
import 'package:church_clique/core/components/input_control.dart';
import 'package:church_clique/core/components/input_text.dart';
import 'package:church_clique/core/components/send_button.dart';
import 'package:church_clique/features/form/data/data.dart';
import 'package:church_clique/features/form/widgets/drop_down.dart';
import 'package:church_clique/features/home/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formatter = DateFormat.yMMMd();
  final _formKey = GlobalKey<FormState>();
  final date = DateTime.now();
  final firstDate = DateTime(1900);
  AdvancedDrawerController controller = AdvancedDrawerController();
  GetData data = GetData();

  TextEditingController dateController() {
    return DoBDate == null
        ? TextEditingController(
            text: "Date of Birth",
          )
        : TextEditingController(text: formatter.format(DoBDate!));
  }

  TextEditingController registrationController() {
    return regisDate == null
        ? TextEditingController(text: 'Date of Registration')
        : TextEditingController(
            text: formatter.format(regisDate!),
          );
  }

  DateTime toDayDate() {
    return DateTime(date.year, date.month, date.day);
  }

  DateTime? _pickedDate;
  DateTime? DoBDate;
  DateTime? regisDate;
  // TODO:modify the last date

  void chosenDate(void Function(DateTime? pickedDate)? value) async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      initialDate: toDayDate(),
      lastDate: toDayDate(),
    );

    setState(() {
      _pickedDate = pickedDate;
    });

    value!(_pickedDate);
  }

  @override
  void dispose() {
    controller.dispose();
    registrationController().dispose();
    dateController().dispose();
    super.dispose();
  }

  void goToNextPage() {
    if (!_formKey.currentState!.validate()) {
      if (regisDate == null || DoBDate == null) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Date of Birth or Registration date empty"),
            duration: Duration(seconds: 2),
          ),
        );
      }
      return;
    }

    _formKey.currentState!.save();
    Navigator.of(context).pushNamed('second_form');
  }

  @override
  Widget build(BuildContext context) {
    return HomeDrawer(
      controller: controller,
      child: Scaffold(
        body: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result){
            dialogBox(context);
          },
          child: SafeArea(
            child: KeyboardDismissOnTap(
              child: SingleChildScrollView(
                child: Consumer<GetData>(
                  builder: (_, data, __) {
                    return Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            inputText(MaterialCommunityIcons.account_outline,
                                'Full Name', TextInputType.text, (value) {
                              data.saveFullName(value);
                            }, (value) {
                              if (value!.trim().isEmpty ||
                                  RegExp(r'\d').hasMatch(value)) {
                                return 'Please enter name';
                              }
                              return null;
                            }),
                            DateTimePickerWidget(
                              onSaved: (value) {
                                data.dateOfBirth = value!;
                              },
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'Please choose date of birth';
                                }
                                return null;
                              },
                              controller: dateController(),
                              hintText: 'Date of Birth',
                              onPressed: () {
                                chosenDate(
                                  (pickedDate) {
                                    DoBDate = pickedDate;
                                  },
                                );
                              },
                            ),
                            DateTimePickerWidget(
                              onSaved: (value) {
                                data.dateOfRegistration = value!;
                              },
                              controller: registrationController(),
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'Choose date of registration';
                                }
                                return null;
                              },
                              onPressed: () {
                                chosenDate(
                                  (pickedDate) {
                                    regisDate = pickedDate;
                                  },
                                );
                              },
                              hintText: 'Date of Registration',
                            ),
                            const SizedBox(height: 10),
                            BuildTextInput(
                              onSaved: (value) {
                                data.amountPaid = value!;
                              },
                              validator: (value) {
                                if (value!.trim().isEmpty ||
                                    !RegExp(r'\d').hasMatch(value)) {
                                  return 'Invalid amount';
                                }
                                return null;
                              },
                              icon: Icons.payment_outlined,
                              hintText: 'Amount Paid GHC',
                            ),
                            const SizedBox(height: 10),
                            BuildTextInput(
                              type: TextInputType.text,
                              onSaved: (value) {
                                data.amountInWords = value!;
                              },
                              validator: (value) {
                                if (value!.trim().isEmpty ||
                                    !RegExp(r'\S').hasMatch(value)) {
                                  return 'Please enter amount in words';
                                }
                                return null;
                              },
                              icon: MaterialCommunityIcons.alphabetical,
                              hintText: 'Amount Paid in Words',
                            ),
                            const SizedBox(height: 10),
                            BuildTextInput(
                              onSaved: (value) {
                                data.receiptNumber = value!;
                              },
                              validator: (value) {
                                if (value!.trim().isEmpty ||
                                    !RegExp(r'\d').hasMatch(value)) {
                                  return 'Please enter a number';
                                }
                                return null;
                              },
                              icon: MaterialCommunityIcons.numeric,
                              hintText: 'receipt number',
                            ),
                            const SizedBox(height: 10),
                            BuildTextInput(
                              onSaved: (value) {
                                data.contact = value!;
                              },
                              type: TextInputType.phone,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'required field';
                                }
                                return null;
                              },
                              icon: Icons.phone_android,
                              hintText: 'contact',
                            ),
                            const SizedBox(height: 10),
                            sendButton(
                              context: context,
                              onTap: goToNextPage,
                              text: 'Next',
                              icon: MaterialCommunityIcons.arrow_right,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
