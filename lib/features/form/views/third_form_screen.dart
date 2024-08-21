import 'package:church_clique/core/components/drop_down.dart';
import 'package:church_clique/core/components/input_control.dart';
import 'package:church_clique/core/components/input_text.dart';
import 'package:church_clique/core/components/send_button.dart';
import 'package:church_clique/features/form/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:provider/provider.dart';

class ThirdFormScreen extends StatefulWidget {
  const ThirdFormScreen({super.key});

  @override
  State<ThirdFormScreen> createState() => _ThirdFormScreenState();
}

class _ThirdFormScreenState extends State<ThirdFormScreen> {
  final _formKey = GlobalKey<FormState>();
  GetData data = GetData();

  void goToNextPage() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    Navigator.of(context).pushNamed('fourth_form');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: KeyboardDismissOnTap(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Consumer<GetData>(
                  builder: (_, data, __) {
                    return Column(
                      children: [
                        BuildTextInput(
                          type: TextInputType.text,
                          icon: Icons.person_outline_outlined,
                          hintText: 'Name of Spouse (IF MARRIED)',
                          validator: (value) {
                            if (RegExp(r'\d').hasMatch(value!)) {
                              return "Please enter  alphabets";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            data.saveNameOfSpouse(value);
                          },
                        ),
                        const SizedBox(height: 10),
                        dropDownButton(
                          (value) {
                          data.saveLifeStatus(value);
                        }),
                        const SizedBox(height: 20),
                        BuildTextInput(
                          onSaved: (value) {
                            data.saveNoChildren(value);
                          },
                          validator: (value) {
                            if (RegExp(r'\d').hasMatch(value!)) {
                              return "Please enter digits only ";
                            }
                            return null;
                          },
                          type: TextInputType.number,
                          icon: Icons.boy,
                          hintText: "Number of children",
                        ),
                        const SizedBox(height: 10),
                        BuildTextInput(
                          validator: (value) {
                            if (RegExp(r'\d').hasMatch(value!)) {
                              return 'Please enter alphabets only';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            data.saveNameOfChildren(value);
                          },
                          maxLines: null,
                          type: TextInputType.multiline,
                          icon: MaterialCommunityIcons.alphabetical,
                          hintText: 'Names of Children',
                        ),
                        const SizedBox(height: 10),
                        BuildTextInput(
                          type: TextInputType.text,
                          onSaved: (value) {
                            data.saveOccupation(value);
                          },
                          validator: (value) {
                            if (value!.trim().isEmpty ||
                                RegExp(r'\d').hasMatch(value)) {
                              return "Please enter letters only";
                            }
                            return null;
                          },
                          icon: MaterialCommunityIcons.worker,
                          hintText: 'Occupation',
                        ),
                        const SizedBox(height: 10),
                        inputText(
                          Icons.man_outlined,
                          'Biological Father\'s name',
                          TextInputType.text,
                          (value) {
                            data.saveFatherName(value);
                          },
                          (value) {
                            if (value!.trim().isEmpty ||
                                RegExp(r'\d').hasMatch(value)) {
                              return 'Please enter characters only';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        dropDownButton(
                          (value) {
                            data.saveFLifeStatus(value);
                          },
                          (value) {
                            if (value == null) {
                              return "Please select status ";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        sendButton(
                          context: context,
                          onTap: goToNextPage,
                          text: 'Next',
                          icon: MaterialCommunityIcons.arrow_right,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        )
                      ],
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
