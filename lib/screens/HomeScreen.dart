part of 'screens.dart';

class HomeScreen extends StatelessWidget {
  final User firebaseUser;
  HomeScreen(this.firebaseUser);
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
                  Text("Hi ${firebaseUser.email}",
                      style: kmainText.copyWith(fontWeight: FontWeight.w700)),
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
                      child: Text(
                        "Rp2.450.000",
                        style: knumberText,
                      )),
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
                                  AuthServices.signOut();
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
