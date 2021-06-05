part of 'screens.dart';

class ProfileScreen extends StatelessWidget {
  final String userId;
  ProfileScreen(this.userId);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
          return;
        },
        child: Scaffold(
          backgroundColor: kmainColor,
          body: SafeArea(
              child: ListView(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: FutureBuilder<FineUser>(
                    future: FineUserServices.getUser(userId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text("Name: ${snapshot.data.name}",
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
                    future: FineUserServices.getUser(userId),
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
            ],
          )),
        ));
  }
}
