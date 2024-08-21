class TransactionModel {
  final double amount;
  final String email;
  final DateTime date;

  TransactionModel({
    required this.amount,
    required this.email,
    required this.date,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      amount: json['amount'],
      email: json['email'],
      date: json['date'],
    );
  }
}
