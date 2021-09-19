part of 'widgets.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({Key key}) : super(key: key);

  @override
  _HeaderSectionState createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return FutureBuilder<FineUser>(
        future: FineUserServices.getUser(user.uid, context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Hi, ${snapshot.data.name}", style: kmainText),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen(user.uid)));
                  },
                  child: CircleAvatar(
                    child: Icon(
                      Icons.account_circle_rounded,
                      size: 45,
                    ),
                    backgroundColor: kmainColor,
                    foregroundColor: Colors.white,
                  ),
                )
              ],
            );
          } else if (!snapshot.hasData) {
            return SpinKitFadingCircle(
              color: Colors.white,
              size: 30,
            );
          } else {
            return Text('Error getting name');
          }
        });
  }
}
