
class TotalMembersModel {
  final int totalMembers;
  TotalMembersModel({required this.totalMembers});

  factory TotalMembersModel.fromJson(Map<String, dynamic> json){
    return TotalMembersModel(totalMembers: json['totalMembers']);
  }
}