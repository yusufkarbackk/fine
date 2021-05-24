part of 'Services.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future signIn() async {}

  static Future<void> signOut() => _auth.signOut();

  static Stream<User> get firebaseUserStream =>
      _auth.authStateChanges();
}
