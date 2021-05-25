part of 'Services.dart';

class FineUserServices {
  static CollectionReference _fineUserCollection =
      FirebaseFirestore.instance.collection("Fine Users");

  static Future<void> updateUser(FineUser user) async {
    _fineUserCollection
        .doc(user.id)
        .set({"email": user.email, "name": user.name, "amount": user.amount});
  }
}
