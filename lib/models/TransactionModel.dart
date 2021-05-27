part of 'Models.dart';

class TransactionModel {
  final String userId;
  final int amount;
  final DateTime time;
  final String category;
  final bool isIncome;

  TransactionModel(
      {this.userId,
      this.amount,
      this.time,
      this.category,
      this.isIncome = false});
}
