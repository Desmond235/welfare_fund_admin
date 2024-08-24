// DataRow getRows(MembershipModel item) {
  //   return DataRow(
  //     cells: [
  //       createTitleCell(item.full_name.toString(), _isEditMode,
  //           onSaved: (value) {
  //         fullNameController = value!;
  //         print(fullNameController);
  //       }),
  //       createTitleCell(item.date_of_birth.toString(), _isEditMode,
  //           onSaved: (value) {
  //         dateOfBirthController = value!;
  //         print(dateOfBirthController);
  //       }),
  //       createTitleCell(item.date_of_registration.toString(), _isEditMode,
  //           onSaved: (value) {
  //         dateOfRegistrationController = value!;
  //       }),
  //       createTitleCell(item.contact.toString(), _isEditMode, onSaved: (value) {
  //         contactController = value!;
  //       }),
  //       createTitleCell(item.house_number.toString(), _isEditMode,
  //           onSaved: (value) {
  //         houseNumberController = value!;
  //       }),
  //       createTitleCell(item.place_of_abode.toString(), _isEditMode,
  //           onSaved: (value) {
  //         placeOfAbodeController = value!;
  //       }),
  //       createTitleCell(item.land_mark.toString(), _isEditMode,
  //           onSaved: (value) {
  //         landMarkController = value!;
  //       }),
  //       createTitleCell(item.home_town.toString(), _isEditMode,
  //           onSaved: (value) {
  //         homeTownController = value!;
  //       }),
  //       createTitleCell(item.region.toString(), _isEditMode, onSaved: (value) {
  //         regionController = value!;
  //       }),
  //       createTitleCell(item.marital_status.toString(), _isEditMode,
  //           onSaved: (value) {
  //         maritalStatusController = value!;
  //       }),
  //       createTitleCell(item.name_of_spouse.toString(), _isEditMode,
  //           onSaved: (value) {
  //         nameOfSpouseController = value!;
  //       }),
  //       createTitleCell(item.life_status.toString(), _isEditMode,
  //           onSaved: (value) {
  //         lifeStatusController = value!;
  //       }),
  //       // _createTitleCell(item.no_of_children.toString(),_isEditMode),
  //       // _createTitleCell(item.names_of_children.toString(),_isEditMode),
  //       createTitleCell(item.occupation.toString(), _isEditMode,
  //           onSaved: (value) {
  //         occupationController = value!;
  //       }),
  //       createTitleCell(item.fathers_name.toString(), _isEditMode,
  //           onSaved: (value) {
  //         fatherNameController = value!;
  //       }),
  //       createTitleCell(item.father_life_status.toString(), _isEditMode,
  //           onSaved: (value) {
  //         fatherLifeStatusController = value!;
  //       }),
  //       createTitleCell(item.mothers_name.toString(), _isEditMode,
  //           onSaved: (value) {
  //         motherNameController = value!;
  //       }),
  //       createTitleCell(item.mother_life_status.toString(), _isEditMode,
  //           onSaved: (value) {
  //         motherLifeStatusController = value!;
  //       }),
  //       createTitleCell(item.next_of_kin.toString(), _isEditMode,
  //           onSaved: (value) {
  //         nextOfKinContactController = value!;
  //       }),
  //       createTitleCell(item.next_of_kin_contact.toString(), _isEditMode,
  //           onSaved: (value) {
  //         nextOfKinContactController = value!;
  //       }),
  //       createTitleCell(item.class_leader.toString(), _isEditMode,
  //           onSaved: (value) {
  //         classLeaderController = value!;
  //       }),
  //       createTitleCell(item.class_leader_contact.toString(), _isEditMode,
  //           onSaved: (value) {
  //         classLeaderContactController = value!;
  //       }),
  //       createTitleCell(item.organization_of_member.toString(), _isEditMode,
  //           onSaved: (value) {
  //         organizationOfMemberController = value!;
  //       }),
  //       createTitleCell(item.org_leader_contact.toString(), _isEditMode,
  //           onSaved: (value) {
  //         orgLeaderContactController = value!;
  //       })
  //     ],
  //   );
  // }


//     Map<String, dynamic> memberData = {
//   'fullName': fullNameController,
//   'dateOfBirth': dateOfBirthController,
//   'dateOfRegistration': dateOfRegistrationController,
//   'contact': contactController,
//   'houseNo': houseNumberController,
//   'placeOfAbode': placeOfAbodeController,
//   'landmark': landMarkController,
//   'homeTown': homeTownController,
//  'region': regionController,
//  'maritalStatus': maritalStatusController,
//   'nameOfSpouse': nameOfSpouseController,
//   'lifeStatus': lifeStatusController,
//   'occupation': occupationController,
//   'fatherName': fatherNameController,
//   'fLifeStatus': fatherLifeStatusController,
//  'motherName': motherNameController,
//  'mLifeStatus': motherLifeStatusController,
//   'nextOfKin': nextOfKinController,
//   'nextOfKinContact': nextOfKinContactController,
//   'classLeader': classLeaderController,
//   'classLeaderContact': classLeaderContactController,
//   'orgOfMember': organizationOfMemberController,
//   'orgLeaderContact': orgLeaderContactController,
// };

    // UpdateMembersResponse.updateMembers(
    //   id,
    //   memberData,
    //  context
    // );


// floatingActionButton: _isEditMode
      //     ? FloatingActionButton(
      //         onPressed: () { 
      //           // print(members!.id);
      //           // // print(members!.full_name);
      //           // updateMembers(members!.id);
      //           },
      //         backgroundColor: priCol(context),
      //         child: const Icon(
      //           Icons.save,
      //           color: Colors.white,
      //         ),
      //       )
      //     : null,


      // Row _switchField() {
  //   return Row(
  //     children: [
  //       const Text('Edit mode'),
  //       Padding(
  //         padding: const EdgeInsets.only(left: 10),
  //         child: Switch(
  //           value: _isEditMode,
  //           onChanged: (value) {
  //             setState(() {
  //               _isEditMode = value;
  //             });
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

   // DataRow getRows(TransactionModel item) {
  //   return DataRow(
  //     cells: [
  //       createTitleCell(item.id.toString(), _isEditMode, onSaved: (value) {
  //         fullNameController = value!;
  //         print(fullNameController);
  //       }),
  //       createTitleCell(item.email.toString(), _isEditMode, onSaved: (value) {
  //         dateOfBirthController = value!;
  //         print(dateOfBirthController);
  //       }),
  //       createTitleCell(item.amount.toString(), _isEditMode, onSaved: (value) {
  //         dateOfRegistrationController = value!;
  //       }),
  //       createTitleCell(item.date.toString(), _isEditMode, onSaved: (value) {
  //         contactController = value!;
  //       }),
  //     ],
  //   );
  // }
