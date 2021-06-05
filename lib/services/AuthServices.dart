part of 'Services.dart';

class AuthServices extends ChangeNotifier {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      UserCredential authResult = result;
      User user = result.user;
      return SignInSignUpResult(authUser: null, user: user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split("]")[1]);
    }
  }

  static Future<SignInSignUpResult> signUp(
      String email, String password, int amount, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      FineUser fineUser =
          result.user.convertToFineUser(amount: amount, name: name);

      await FineUserServices.updateUser(fineUser);
      User user = result.user;
      UserCredential authResult = result;

      return SignInSignUpResult(authUser: authResult, user: user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(',')[1]);
    }
  }

  static Future<void> signOut() => _auth.signOut();

  static Stream<User> get firebaseUserStream {
    return _auth.authStateChanges();
  }
}

class SignInSignUpResult {
  final UserCredential authUser;
  final User user;
  final String message;
  final String hasil;

  SignInSignUpResult({this.message, this.authUser, this.hasil, this.user});
}
