// ignore: unused_import
import 'package:church_clique/core/base/main/mainscreen.dart';
import 'package:church_clique/core/components/drop_down.dart';
import 'package:church_clique/core/components/input_control.dart';
import 'package:church_clique/core/components/input_text.dart';
import 'package:church_clique/core/components/next-of-kin_class-leader.dart';
import 'package:church_clique/core/components/send_button.dart';
import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/core/service/membership_service.dart';
import 'package:church_clique/features/form/data/data.dart';
import 'package:church_clique/features/form/provider/form_state.dart';
import 'package:church_clique/features/onboard/provider/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

class FourthFormScreen extends StatefulWidget {
  const FourthFormScreen({super.key});

  @override
  State<FourthFormScreen> createState() => _FourthFormScreenState();
}

class _FourthFormScreenState extends State<FourthFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late MemFormState provider;

//   @override
//   void initState() {
//     super.initState();
//   }

//  @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//      provider = Provider.of<MemFormState>(context);
//     provider.getFormState();

//     if (provider.isFillMemFrom) {
//       WidgetsBinding.instance.addPostFrameCallback((_){
//         Navigator.of(context).pushReplacementNamed('main');
//       });
//     }
//   }
  final GetData data = GetData();

  void sendForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    var membership = Provider.of<GetData>(context, listen: false);
    final prefs = await sharedPrefs;
    int userId = Provider.of<MemFormState>(context, listen: false).userId;

    final data = {
      "userId": userId,
      'fullName': membership.fullName,
      'dateOfBirth': membership.dateOfBirth,
      'dateOfRegistration': membership.dateOfRegistration,
      'amountPaid': membership.amountPaid,
      'amountInWords': membership.amountInWords,
      'receiptNumber': membership.receiptNumber,
      'contact': membership.contact,
      'houseNo': membership.houseNo,
      'placeOfAbode': membership.placeOfAbode,
      'landmark': membership.landmark,
      'homeTown': membership.homeTown,
      'region': membership.region,
      'maritalStatus': membership.maritalStatus,
      'others': membership.others,
      'nameOfSpouse': membership.nameOfSpouse,
      "lifeStatus": membership.lifeStatus,
      'numberOfChildren': membership.numberOfChildren,
      'namesOfChildren': membership.namesOfChildren,
      'occupation': membership.occupation,
      'fatherName': membership.fatherName,
      'fLifeStatus': membership.fLifeStatus,
      'motherName': membership.motherName,
      'mLifeStatus': membership.mLifeStatus,
      'nextOfKin': membership.nameOfNextKin,
      'nextOfKinContact': membership.nextOfKinContact,
      'classLeader': membership.classLeader,
      'classLeaderContact': membership.classLeaderContact,
      'orgOfMember': membership.orgOfMember,
      'orgLeaderContact': membership.orgLeaderContact
    };
    
    if(!mounted){
      return;
    }
    MembershipService.post(data, context);
    Provider.of<OnboardingPage>(context, listen: false).setOnboarded(true);

    print(data);

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
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: BuildTextInput(
                            type: TextInputType.text,
                            onSaved: (value) {
                              data.saveMotherName(value);
                            },
                            validator: (value) {
                              if (value!.trim().isEmpty ||
                                  !RegExp(r'\S( )?').hasMatch(value)) {
                                return "Please enter letters only";
                              }
                              return null;
                            },
                            icon: Icons.woman_outlined,
                            hintText: 'Biological Mother\'s name',
                          ),
                        ),
                        const SizedBox(height: 10),
                        dropDownButton((value) {
                          data.saveMLifeStatus(value);
                        }, (value) {
                          if (value == null) {
                            return "Please select status";
                          }
                          return null;
                        }),
                        const SizedBox(height: 10),
                        kinClassLeader('Next of Kin', context,
                            isClassLeader: false, onSaved: (value) {
                          data.saveNextOfKin(value);
                        }),
                        const SizedBox(height: 10),
                        kinClassLeader(
                            'Class Leader',
                            isClassLeader: true,
                            context, onSaved: (value) {
                          data.saveClassLeader(value);
                        }),
                        const SizedBox(height: 10),
                        inputText(
                            Icons.person,
                            'Organization of Member (if applicable)',
                            TextInputType.text, (value) {
                          data.saveOrgOfMember(value);
                        }, (value) {
                          if (RegExp(r'\d').hasMatch(value!)) {
                            return 'Please enter alphabets only';
                          }
                          return null;
                        }),
                        const SizedBox(height: 10),
                        inputText(
                          Icons.phone,
                          'Org. Leader\'s Contact',
                          TextInputType.phone,
                          (value) {
                            data.saveOrgLeaderContact(value);
                          },
                        ),
                        const SizedBox(height: 10),
                        sendButton(
                            context: context,
                            onTap: sendForm,
                            text: 'Submit',
                            icon: Icons.send,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween)
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
