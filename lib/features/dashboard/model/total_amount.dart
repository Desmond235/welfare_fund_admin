class TotalAmountModel {
  final int totalAmount;
  TotalAmountModel({required this.totalAmount});

  factory TotalAmountModel.fromJson(Map<String, dynamic> json){
    return TotalAmountModel(totalAmount: json['total_amount']);
  }
}