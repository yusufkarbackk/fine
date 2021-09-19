import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FineUserProvider extends ChangeNotifier {
  String _name = 'no Name';
  String _id = "";
  String _email = "";
  int _balance = 0;

  String get getUserID => _id;
  String get getUserName => _name;
  String get getuserEmail => _email;
  int get getUserBalance => _balance;

  set setUserID(String id) => _id = id;
  set setUsername(String name) => _name = name;
  set setUserEmail(String email) => _email = email;
  set setUserBalance(int balance) => _balance = balance;
}
