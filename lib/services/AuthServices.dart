part of 'Services.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future signIn(String email, String password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  static Future<FineUser> signUp(
      String email, String password, int amount, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      FineUser firebaseUser =
          result.user.convertToFineUser(amount: amount, name: name);
      return firebaseUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<void> signOut() => _auth.signOut();

  static Stream<User> get firebaseUserStream => _auth.authStateChanges();
}
