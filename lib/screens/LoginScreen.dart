part of 'screens.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return;
      },
      child: Scaffold(
        body: SafeArea(
            bottom: false,
            maintainBottomViewPadding: false,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Sign In",
                              style: kmainText.copyWith(
                                  fontSize: 40,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 22),
                          Container(
                            child: Column(
                              children: [
                                TextField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.green[600])),
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: "Email",
                                      labelStyle:
                                          TextStyle(color: Colors.green[600]),
                                    )),
                                SizedBox(height: 10),
                                TextField(
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.green[600])),
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: "Password",
                                      labelStyle:
                                          TextStyle(color: Colors.green[600]),
                                    )),
                              ],
                            ),
                          )
                        ],
                      )),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {},
                      color: Colors.green[400],
                      child: Center(
                        child: Text("Login"),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
