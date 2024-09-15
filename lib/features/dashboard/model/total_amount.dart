class TotalAmountModel {
  final int totalAmount;
  final String month;
  TotalAmountModel({required this.month, required this.totalAmount});

  factory TotalAmountModel.fromJson(Map<String, dynamic> json) {
    return TotalAmountModel(
      month: json['month'],
      totalAmount: json['total_amount'],
    );
  }
}
