part of 'screens.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kmainColor,
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "Fine",
              style: kmainText,
            ),
            Container(
              child: Column(
                children: [
                  Text("Welcome Back to Fine"),
                  SizedBox(
                    height: 18,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Email"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Password"),
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {},
              color: Colors.orangeAccent,
              child: Center(
                child: Text("Login"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
