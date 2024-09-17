import 'dart:convert';

import 'package:welfare_fund_admin/features/dashboard/model/gender_model.dart';
import 'package:welfare_fund_admin/features/dashboard/model/total_amount.dart';
import 'package:welfare_fund_admin/features/dashboard/model/total_members_model.dart';
import 'package:http/http.dart' as http;

class DashboardService {
  static Future<TotalMembersModel> totalMembers() async{
    const url = 'http://10.0.2.2:3000/api/admin/';
    final response = await http.get(Uri.parse('${url}total-members'));

    if (response.statusCode == 200){
      final jsonResponse = jsonDecode(response.body);
      return TotalMembersModel.fromJson(jsonResponse);
    }
    else{
      print(response.statusCode);
      return TotalMembersModel(totalMembers: 0);
    }
  }

  static Future<List<GenderModel>> gender() async{
      const url = 'http://10.0.2.2:3000/api/admin/';
    final response = await http.get(Uri.parse('${url}count-gender'));

    if (response.statusCode == 200){
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      final List<GenderModel> gender = jsonResponse.map((data) => GenderModel.fromJson(data)).toList();
      return gender;
    }
    else{
      return [];
    } 
  }

  static Future<List<TotalAmountModel>> totalAmount() async{
    const url = 'http://10.0.2.2:3000/api/admin/';
    final response = await http.get(Uri.parse('${url}total-amount'));

    if (response.statusCode == 200){
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => TotalAmountModel.fromJson(data)).toList();
    }
    else{
      return [];
    }
  }
}