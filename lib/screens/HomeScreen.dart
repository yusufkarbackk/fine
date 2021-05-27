part of 'screens.dart';

class HomeScreen extends StatefulWidget {
  final String fineUserId;
  HomeScreen(this.fineUserId);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    FineUserServices.getUser(widget.fineUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kmainColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<FineUser>(
                      future: FineUserServices.getUser(widget.fineUserId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text("Hi, ${snapshot.data.name}",
                              style: kmainText);
                        } else if (!snapshot.hasData) {
                          return Text(widget.fineUserId);
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                  SizedBox(
                    height: 22,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Balance",
                        style: ksecondaryText,
                      )),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.center,
                    child: FutureBuilder<FineUser>(
                        future: FineUserServices.getUser(widget.fineUserId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              "Rp${snapshot.data.amount}",
                              style: knumberText,
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                ],
              ),
            ),
            // NOTE:activities content
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Activities",
                            style:
                                ksecondaryText.copyWith(color: Colors.black)),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) =>
                                          FutureBuilder<FineUser>(
                                              future: FineUserServices.getUser(
                                                  widget.fineUserId),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return IncomeScreen(
                                                      widget.fineUserId,
                                                      snapshot.data.amount);
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
                              child: ActivitiesWidget(
                                icon: Icons.money_off_csred_rounded,
                                text: "Spending",
                              ),
                            ),
                            SizedBox(
                              width: 14,
                            ),
                            Expanded(
                              child: ActivitiesWidget(
                                icon: Icons.data_usage_rounded,
                                text: "Reports",
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Text('Transactions',
                            style:
                                ksecondaryText.copyWith(color: Colors.black)),
                        SizedBox(
                          height: 16,
                        ),
                        TransactionWidget(
                          text: "Foods & Baverages",
                          amount: -50000,
                          isIncome: false,
                        ),
                        TransactionWidget(
                          text: "Foods & Baverages",
                          amount: -50000,
                          isIncome: false,
                        ),
                        TransactionWidget(
                          text: "Salary",
                          amount: 50000,
                          isIncome: true,
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
