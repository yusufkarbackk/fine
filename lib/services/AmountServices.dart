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

  static Stream<QuerySnapshot> getLastTransactions(String id) {
    Stream<QuerySnapshot> snapshots = _amountCollection
        .orderBy('time', descending: true)
        .where('userId', isEqualTo: id)
        .snapshots()
        .take(3);
    return snapshots;
  }

  static Stream<QuerySnapshot> getAllTransactions(String id) {
    Stream<QuerySnapshot> snapshots =
        _amountCollection.where('userId', isEqualTo: id).snapshots();

    return snapshots;
  }

  static Map<String, double> mappingTransactions(
      List<QueryDocumentSnapshot> transactions) {
    ReportModel reportModel = ReportModel();
    for (var transaction in transactions) {
      if (transaction.data()['category'] == 'Food') {
        reportModel.foods = 1000.0;
      } else if (transaction.data()['category'] == 'Transportation') {
        reportModel.transportation = 5000.0;
      } else if (transaction.data()['category'] == 'Entertainment') {
        int valInt = transaction.data()['amount'];
        reportModel.entertainment = 3000.0;
      } else if (transaction.data()['category'] == 'Shopping') {
        int valInt = transaction.data()['amount'];
        double valDouble = valInt.toDouble();
        reportModel.shopping += valDouble;
      } else if (transaction.data()['category'] == 'Salary') {
        int valInt = transaction.data()['amount'];
        double valDouble = valInt.toDouble();
        reportModel.salary = valInt;
      } else if (transaction.data()['category'] == 'Gifts') {
        int valInt = transaction.data()['amount'];
        double valDouble = valInt.toDouble();
        reportModel.gift = valInt;
      } else if (transaction.data()['category'] == 'Payback') {
        int valInt = transaction.data()['amount'];
        double valDouble = valInt.toDouble();
        reportModel.payback = valInt;
      } else if (transaction.data()['category'] == 'Investment') {
        int valInt = transaction.data()['amount'];
        double valDouble = valInt.toDouble();
        reportModel.investment = valInt;
      }
    }

    Map<String, double> mapData = {
      'Foods & Baverages': reportModel.foods,
      'Transportation': 5000.0,
      'Entertainment': 3000.0,
      'Shopping': reportModel.shopping
    };

    return mapData;
  }
}
