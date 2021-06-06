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
        if (transaction.data()['amount'] == null) {
          reportModel.foods += 0;
        } else {
          int valInt = transaction.data()['amount'];
          double valDouble = valInt.toDouble();
          reportModel.foods = valDouble;
        }
      } else if (transaction.data()['category'] == 'Transportation') {
        if (transaction.data()['amount'] == null) {
          reportModel.transportation += 0;
        } else {
          int valInt = transaction.data()['amount'];
          double valDouble = valInt.toDouble();
          reportModel.transportation = valDouble;
        }
      } else if (transaction.data()['category'] == 'Entertainment') {
        if (transaction.data()['amount'] == null) {
          reportModel.entertainment += 0;
        } else {
          int valInt = transaction.data()['amount'];
          double valDouble = valInt.toDouble();
          reportModel.entertainment = valDouble;
        }
      } else if (transaction.data()['category'] == 'Shopping') {
        if (transaction.data()['amount'] == null) {
          reportModel.shopping += 0;
        } else {
          int valInt = transaction.data()['amount'];
          double valDouble = valInt.toDouble();
          reportModel.shopping = valDouble;
        }
      } else if (transaction.data()['category'] == 'Salary') {
        if (transaction.data()['amount'] == null) {
          reportModel.salary += 0;
        } else {
          int valInt = transaction.data()['amount'];
          double valDouble = valInt.toDouble();
          reportModel.salary = valDouble;
        }
      } else if (transaction.data()['category'] == 'Gifts') {
        if (transaction.data()['amount'] == null) {
          reportModel.gift += 0;
        } else {
          int valInt = transaction.data()['amount'];
          double valDouble = valInt.toDouble();
          reportModel.gift = valDouble;
        }
      } else if (transaction.data()['category'] == 'Payback') {
        if (transaction.data()['amount'] == null) {
          reportModel.payback += 0;
        } else {
          int valInt = transaction.data()['amount'];
          double valDouble = valInt.toDouble();
          reportModel.payback = valDouble;
        }
      } else if (transaction.data()['category'] == 'Investment') {
        if (transaction.data()['amount'] == null) {
          reportModel.investment += 0;
        } else {
          int valInt = transaction.data()['amount'];
          double valDouble = valInt.toDouble();
          reportModel.investment = valDouble;
        }
      }
    }

    Map<String, double> mapData = {
      'Foods & Baverages': reportModel.foods,
      'Transportation': 5000.0,
      'Entertainment': 3000.0,
      'Shopping': reportModel.shopping,
      'Salary': reportModel.salary,
      'Gifts': reportModel.gift,
      'Payback': reportModel.payback,
      'Investment': reportModel.investment,
    };

    return mapData;
  }
}
