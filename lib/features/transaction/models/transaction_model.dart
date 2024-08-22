class TransactionModel {
  final int id;
  final double amount;
  final String email;
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.email,
    required this.date,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] ?? 0,
      amount: json['amount'] ?? 0,
      email: json['email'] ?? "",
      date: json['date'] as DateTime,
    );
  }
}
