part of 'screens.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;
  ProfileScreen(this.userId);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GetResult getResult = null;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        },
        child: Scaffold(
          backgroundColor: kmainColor,
          body: SafeArea(
              child: ListView(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: FutureBuilder<FineUser>(
                    future: FineUserServices.getUser(widget.userId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text("Name: " + snapshot.data.name,
                            style: kmainText);
                      } else if (!snapshot.hasData) {
                        return Text("erro getting name");
                      } else {
                        return SpinKitFadingCircle(
                          color: Colors.white,
                          size: 45,
                        );
                      }
                    },
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: FutureBuilder<FineUser>(
                    future: FineUserServices.getUser(widget.userId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text("Email: ${snapshot.data.email}",
                            style: kmainText);
                      } else if (!snapshot.hasData) {
                        return Text("erro getting email");
                      } else {
                        return SpinKitFadingCircle(
                          color: Colors.white,
                          size: 45,
                        );
                      }
                    },
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    width: 250,
                    height: 30,
                    child: RaisedButton(
                      color: Colors.red[400],
                      onPressed: () {
                        AuthServices.signOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomeScreen()));
                      },
                      child: Center(
                          child: Text(
                        "Sign Out",
                        style: ksecondaryText,
                      )),
                    ),
                  )),
              SizedBox(
                height: 40,
              ),
              Center(
                  child: Text((getResult != null)
                      ? getResult.email + " " + getResult.name
                      : "error")),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    width: 250,
                    height: 30,
                    child: RaisedButton(
                      color: Colors.red[400],
                      onPressed: () {
                        GetResult.connectAPI("9").then((value) {
                          setState(() {
                            getResult = value;
                          });
                        });
                      },
                      child: Center(
                          child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "get",
                          style: ksecondaryText.copyWith(fontSize: 22),
                        ),
                      )),
                    ),
                  )),
            ],
          )),
        ));
  }
}
