part of 'Models.dart';

class TransactionModel {
  String userId;
  int amount;
  DateTime time;
  String category;
  bool isIncome;

  TransactionModel(
      {this.userId,
      this.amount,
      this.time,
      this.category,
      this.isIncome = false});
}
