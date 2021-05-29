part of 'screens.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isNameValid = false;
  bool isAmountValid = false;
  bool isSignUp = false;

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
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Sign Up",
                                  style: kmainText.copyWith(
                                      fontSize: 40,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 22),
                              Container(
                                child: Column(
                                  children: [
                                    TextFieldWidget(
                                      onChanged: (text) {
                                        setState(() {
                                          isNameValid = text.length > 0;
                                        });
                                      },
                                      controller: nameController,
                                      inputType: TextInputType.text,
                                      labelText: "Name",
                                      borderSide:
                                          BorderSide(color: Colors.green[600]),
                                    ),
                                    SizedBox(height: 10),
                                    TextFieldWidget(
                                      onChanged: (text) {
                                        setState(() {
                                          isEmailValid =
                                              EmailValidator.validate(text);
                                        });
                                      },
                                      controller: emailController,
                                      inputType: TextInputType.text,
                                      labelText: "Email",
                                      isPassword: false,
                                      borderSide:
                                          BorderSide(color: Colors.green[600]),
                                    ),
                                    SizedBox(height: 10),
                                    TextFieldWidget(
                                      onChanged: (text) {
                                        setState(() {
                                          isPasswordValid = text.length >= 6;
                                        });
                                      },
                                      controller: passwordController,
                                      inputType: TextInputType.text,
                                      labelText: "Password",
                                      isPassword: true,
                                      borderSide:
                                          BorderSide(color: Colors.green[600]),
                                    ),
                                    SizedBox(height: 10),
                                    TextFieldWidget(
                                      onChanged: (text) {
                                        setState(() {
                                          isAmountValid = text.length > 0;
                                        });
                                      },
                                      controller: amountController,
                                      inputType: TextInputType.number,
                                      labelText: "Balance",
                                      isPassword: false,
                                      borderSide:
                                          BorderSide(color: Colors.green[600]),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                      isSignUp
                          ? Center(
                              child: SpinKitFadingCircle(
                                color: Colors.green[400],
                              ),
                            )
                          : Container(
                              width: double.infinity,
                              height: 50,
                              child: RaisedButton(
                                onPressed: () async {
                                  if (isNameValid != true &&
                                      isEmailValid != true &&
                                      isPasswordValid != true &&
                                      isAmountValid != true) {
                                    Flushbar(
                                      duration: Duration(seconds: 4),
                                      flushbarPosition: FlushbarPosition.TOP,
                                      backgroundColor: Color(0xFFFF5C83),
                                      message: "Please Fill All the Fields",
                                    )..show(context);
                                  } else if (isNameValid != true) {
                                    Flushbar(
                                      duration: Duration(seconds: 4),
                                      flushbarPosition: FlushbarPosition.TOP,
                                      backgroundColor: Color(0xFFFF5C83),
                                      message: "Please Fill the Username Field",
                                    )..show(context);
                                  } else if (isEmailValid != true) {
                                    Flushbar(
                                      duration: Duration(seconds: 4),
                                      flushbarPosition: FlushbarPosition.TOP,
                                      backgroundColor: Color(0xFFFF5C83),
                                      message: "Please Fill the Email Field",
                                    )..show(context);
                                  } else if (isPasswordValid != true) {
                                    Flushbar(
                                      duration: Duration(seconds: 4),
                                      flushbarPosition: FlushbarPosition.TOP,
                                      backgroundColor: Color(0xFFFF5C83),
                                      message:
                                          "Please Fill the Password Field with 6 or More Characters",
                                    )..show(context);
                                  } else if (isAmountValid != true) {
                                    Flushbar(
                                      duration: Duration(seconds: 4),
                                      flushbarPosition: FlushbarPosition.TOP,
                                      backgroundColor: Color(0xFFFF5C83),
                                      message:
                                          "Please Fill the balance for your first income",
                                    )..show(context);
                                  } else {
                                    final int amount =
                                        int.tryParse(amountController.text);
                                    SignInSignUpResult user =
                                        await AuthServices.signUp(
                                            emailController.text,
                                            passwordController.text,
                                            amount,
                                            nameController.text);
                                    if (user.message != null) {
                                      setState(() {
                                        isSignUp = false;
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
                                },
                                color: Colors.green[400],
                                child: Center(
                                  child: Text(
                                    "Sign Up",
                                    style: ksecondaryText,
                                  ),
                                ),
                              ),
                            )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
