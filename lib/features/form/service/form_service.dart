import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:welfare_fund_admin/features/form/models/membership_model.dart';

class FormServiceResponse {
  static Future<List<MembershipModel>> getMembershipDetails() async {
     const serverUrl = 'http://10.0.2.2:3000/api/admin/get-members';

    try {
      final response = await http.get(
        Uri.parse(serverUrl),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData= jsonDecode(response.body);
        final List<dynamic> getMembers = responseData['data'];

        final List<MembershipModel> getMembersData =
            getMembers.map((json) => MembershipModel.fromJson(json)).toList();

            print(getMembers);
        return getMembersData;
      }
      // else if(response.statusCode == 404){
      //   return [];
      // }
       else {
        throw Exception("failed to fetch members");
      }
    } on Exception catch (e) {
      throw Exception('an Error occurred: $e');
    }
  }
}
