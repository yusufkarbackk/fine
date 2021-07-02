part of 'Models.dart';

class TransactionModel {
  String userId;
  int amount;
  DateTime time;
  String category;
  bool isIncome;
  String month;

  TransactionModel(
      {this.userId,
      this.amount,
      this.time,
      this.category,
      this.month,
      this.isIncome = false});
}
