part of 'Services.dart';

class AuthServices extends ChangeNotifier {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<User> signInAnonym() async {
    try {
      UserCredential result = await _auth.signInAnonymously();

      User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<User> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static String userId() {
    String user = _auth.currentUser.uid;

    return user;
  }

  static Stream<User> get firebaseUserStream {
    return _auth.authStateChanges();
  }

  static Future<User> signUp(
      String email, String password, int amount, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      FineUser fineUser =
          result.user.convertToFineUser(amount: amount, name: name);

      await FineUserServices.updateUser(fineUser);
      User authResult = result.user;

      return authResult;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<void> signOut() => _auth.signOut();
}
