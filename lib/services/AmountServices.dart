part of 'Services.dart';

class AmountServices {
  static CollectionReference _amountCollection =
      FirebaseFirestore.instance.collection("transactions");

  static Future<void> addUserTransaction(TransactionModel transaction) async {
    await _amountCollection.doc().set({
      "amount": transaction.amount,
      "time": transaction.time.millisecondsSinceEpoch,
      "category": transaction.category,
      "isIncome": transaction.isIncome,
      "userId": transaction.userId
    });
  }

  static Stream<QuerySnapshot> getTransactions(String id) {
    Stream<QuerySnapshot> snapshots = _amountCollection
        .orderBy('time', descending: true)
        .where('userId', isEqualTo: id)
        .snapshots()
        .take(3);
    return snapshots;
  }
}
