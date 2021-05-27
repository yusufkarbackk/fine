part of 'screens.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User fineUser = Provider.of<User>(context);

    return (fineUser == null) ? WelcomeScreen() : HomeScreen(fineUser.uid);
  }
}
