part of 'widgets.dart';

class ActivitiesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => FutureBuilder<FineUser>(
                      future: FineUserServices.getUser(user.uid),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return IncomeScreen(user.uid, snapshot.data.amount);
                        } else {
                          return CircularProgressIndicator();
                        }
                      }));
            },
            child: ActivitiesWidget(
              icon: Icons.payments_rounded,
              text: "Income",
            ),
          ),
        ),
        SizedBox(
          width: 14,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => FutureBuilder<FineUser>(
                      future: FineUserServices.getUser(user.uid),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SpendingScreen(user.uid, snapshot.data.amount);
                        } else {
                          return CircularProgressIndicator();
                        }
                      }));
            },
            child: ActivitiesWidget(
              icon: Icons.money_off,
              text: "Spending",
            ),
          ),
        ),
        SizedBox(
          width: 14,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReportScreen(user.uid)));
            },
            child: ActivitiesWidget(
              icon: Icons.pie_chart_rounded,
              text: "Reports",
            ),
          ),
        )
      ],
    );
  }
}
