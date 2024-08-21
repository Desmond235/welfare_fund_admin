import 'package:church_clique/features/auth/models/user_signin_model.dart';
import 'package:flutter/material.dart';

class GetData extends ChangeNotifier {
  int? userId = SignIn().userId; 
  String fullName = '';
  String dateOfBirth = '';
  String dateOfRegistration = '';
  String amountPaid = '';
  String amountInWords = '';
  String receiptNumber = '';
  String contact = '';
  String houseNo = '';
  String placeOfAbode = '';
  String landmark = '';
  String homeTown = '';
  String region = '';
  String maritalStatus = '';
  String others = '';
  String? nameOfSpouse;
  String? lifeStatus;
  String? numberOfChildren;
  String?namesOfChildren;
  String occupation = '';
  String fatherName = '';
  String fLifeStatus = '';
  String motherName = '';
  String mLifeStatus =  '';
  String nameOfNextKin = '';
  String nextOfKinContact = '';
  String classLeader = '';
  String classLeaderContact = '';
  String ?orgOfMember = '';
  String? orgLeaderContact = '';
 

  void saveFullName(String? value){
  fullName = value!;
 }
 void saveDateOfBirth(String? value){
  dateOfBirth = value!;
 }

 void saveRegistrationDate(String? value){
  dateOfRegistration = value!;
 }

 void saveAmountPaid(String? value){
  amountPaid = value!;
 }
 void saveAmountPaidInWords(String? value){
  amountInWords = value!;
 }
 void saveReceiptNumber (String? value){
  receiptNumber = value!;
 }
 void saveContact(String? value){
  contact = value!;
 }
 void saveHouseNumber(String? value){
  houseNo = value!;
 }
 void savePlaceOfAbode (String? value){
   placeOfAbode = value!;
 }

 void saveLandmark(String? value){
  landmark = value!;
 }
 
 void saveHomeTown(String? value){
  homeTown = value!;
 }

 void saveRegion(String? value){
  region = value!;
 }
 void saveMaritalStatus(String? value){
  maritalStatus = value!;
 }
 void saveOthers(String? value){
  others = value!;
 }
 void saveNameOfSpouse(String? value){
  nameOfSpouse = value;
 }
 void saveLifeStatus(String? value){
  lifeStatus = value;
 }
 void saveNoChildren(String? value){
  numberOfChildren = value;
 }

void saveNameOfChildren(String? value){
  namesOfChildren = value;
}
 void saveOccupation(String? value){
  occupation = value!;
 }

 void saveFatherName( String? value){
  fatherName = value!;
 }

 void saveFLifeStatus(String? value){
  fLifeStatus = value!;
 }

 void saveMotherName(String? value){
  motherName = value!;
 }

 void saveMLifeStatus(String? value){
   mLifeStatus = value!;
 }

 void saveNextOfKin(String? value){
  nameOfNextKin =value!;
 }
 void saveNextOfKinContacts(String? value){
  nextOfKinContact = value!;
 }

 void saveClassLeader(String? value){
  classLeader = value!;
 }

 void saveClassLeaderContact(String? value){
  classLeaderContact = value!;
 }

 void saveOrgOfMember(String? value){
  orgOfMember = value!;
 }

 void saveOrgLeaderContact(String? value){
  orgLeaderContact = value!;
 }
 }