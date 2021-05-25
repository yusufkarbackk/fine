import 'package:fine/models/Models.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseUserExtension on User {
  FineUser convertToFineUser({String name = "No Name", int amount = 0}) =>
      FineUser(this.uid, this.email, name: name, amount: amount);
}
