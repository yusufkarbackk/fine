part of 'screens.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  bool isSignIn = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;
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
                                    onChanged: (text) {
                                      setState(() {
                                        isEmailValid =
                                            EmailValidator.validate(text);
                                      });
                                    },
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
                                    onChanged: (text) {
                                      setState(() {
                                        isPasswordValid = text.length >= 6;
                                      });
                                    },
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
                    child: isSignIn
                        ? Center(
                            child: SpinKitFadingCircle(
                              color: Colors.green[400],
                            ),
                          )
                        : RaisedButton(
                            onPressed: isEmailValid && isPasswordValid
                                ? () async {
                                    setState(() {
                                      isSignIn = true;
                                    });
                                    SignInSignUpResult user =
                                        await AuthServices.signIn(
                                            emailController.text,
                                            passwordController.text);
                                    if (user.message != null) {
                                      setState(() {
                                        isSignIn = false;
                                      });
                                      Flushbar(
                                        duration: Duration(seconds: 4),
                                        flushbarPosition: FlushbarPosition.TOP,
                                        backgroundColor: Color(0xFFFF5C83),
                                        message: user.message,
                                      )..show(context);
                                    } else if (user.user != null) {
                                      String userId = user.user.uid;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen(userId)));
                                    }
                                  }
                                : null,
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
