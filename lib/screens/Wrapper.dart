part of 'screens.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User firebaseUser = Provider.of<User>(context);

    return (firebaseUser == null) ? LoginScreen() : HomeScreen(firebaseUser);
  }
}
