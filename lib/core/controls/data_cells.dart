
import 'package:flutter/material.dart';
import 'package:welfare_fund_admin/features/form/models/membership_model.dart';

List<DataCell> cells ({required MembershipModel item}) {
     return [
      DataCell(Text(item.id.toString())),
      DataCell(Text(item.full_name)),
      DataCell(Text(item.date_of_birth)),
      DataCell(Text(item.date_of_registration)),
      DataCell(Text(item.contact.toString())),
      DataCell(Text(item.house_number)),
      DataCell(Text(item.place_of_abode)),
      DataCell(Text(item.land_mark)),
      DataCell(Text(item.home_town)),
      DataCell(Text(item.region)),
      DataCell(Text(item.marital_status)),
      DataCell(Text(item.name_of_spouse ?? 'N/A')),
      DataCell(Text(item.life_status ?? "N/A")),
      DataCell(Text(item.occupation)),
      DataCell(Text(item.fathers_name)),
      DataCell(Text(item.father_life_status)),
      DataCell(Text(item.mothers_name)),
      DataCell(Text(item.mother_life_status)),
      DataCell(Text(item.next_of_kin)),
      DataCell(Text(item.next_of_kin_contact.toString())),
      DataCell(Text(item.class_leader)),
      DataCell(Text(item.class_leader_contact.toString())),
      DataCell(Text(item.organization_of_member ?? 'N/A')),
      DataCell(Text(item.org_leader_contact.toString()))
    ];
}