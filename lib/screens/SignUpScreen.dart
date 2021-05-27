part of 'screens.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

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
                                      controller: nameController,
                                      inputType: TextInputType.text,
                                      labelText: "Name",
                                    ),
                                    SizedBox(height: 10),
                                    TextFieldWidget(
                                      controller: emailController,
                                      inputType: TextInputType.emailAddress,
                                      labelText: "Email",
                                    ),
                                    SizedBox(height: 10),
                                    TextFieldWidget(
                                      controller: passwordController,
                                      inputType: TextInputType.text,
                                      labelText: "Password",
                                      isPassword: true,
                                    ),
                                    SizedBox(height: 10),
                                    TextFieldWidget(
                                      controller: amountController,
                                      inputType: TextInputType.number,
                                      labelText: "Amount",
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: RaisedButton(
                          onPressed: () async {
                            final int amount =
                                int.tryParse(amountController.text);
                            User user = await AuthServices.signUp(
                                emailController.text,
                                passwordController.text,
                                amount,
                                nameController.text);
                            String userId = user.uid;

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen(userId)));
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
