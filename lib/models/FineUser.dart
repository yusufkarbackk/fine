part of 'Models.dart';

class FineUser extends ChangeNotifier {
  static CollectionReference _fineUserCollection =
      FirebaseFirestore.instance.collection("Fine Users");

  final String id;
  final String name;
  final String email;
  final int amount;

  FineUser(this.id, this.email, {this.name, this.amount = 0});
}
