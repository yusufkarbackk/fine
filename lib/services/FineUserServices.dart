part of 'Services.dart';

class FineUserServices extends ChangeNotifier {
  static CollectionReference _fineUserCollection =
      FirebaseFirestore.instance.collection("Fine Users");

  static Future<void> updateUser(FineUser user) async {
    _fineUserCollection
        .doc(user.id)
        .set({"email": user.email, "name": user.name, "amount": user.amount});
  }

  static Future<FineUser> getUser(String id) async {
    DocumentSnapshot snapshot = await _fineUserCollection.doc(id).get();

    return FineUser(id, snapshot.data()["email"],
        name: snapshot.data()["name"], amount: snapshot.data()["amount"]);
  }

  static Future<void> updateUserBalance(String userId, int amount,
      {int lastAmount, bool isIncome}) async {
    if (isIncome == true) {
      _fineUserCollection.doc(userId).update({"amount": amount + lastAmount});
    } else {
      _fineUserCollection.doc(userId).update({"amount": lastAmount - amount});
    }
  }

  static Stream<DocumentSnapshot> getUserBalance(String id) {
    Stream<DocumentSnapshot> snapshot = _fineUserCollection.doc(id).snapshots();
    return snapshot;
  }
}
