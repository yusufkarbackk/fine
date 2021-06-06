part of 'screens.dart';

class HomeScreen extends StatelessWidget {
  final String userId;
  HomeScreen(this.userId);
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
                  //NOTE: HEADER
                  FutureBuilder<FineUser>(
                      future: FineUserServices.getUser(userId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Hi, ${snapshot.data.name}",
                                  style: kmainText),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProfileScreen(userId)));
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
                    child: StreamBuilder<DocumentSnapshot>(
                        stream: FineUserServices.getUserBalance(userId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.data()['amount'] < 0) {
                              return Text(
                                NumberFormat.currency(
                                        locale: "id_IDR",
                                        decimalDigits: 0,
                                        symbol: "Rp ")
                                    .format(snapshot.data.data()['amount']),
                                style: knumberText.copyWith(
                                    color: Colors.red[600]),
                              );
                            }
                            return Text(
                              NumberFormat.currency(
                                      locale: "id_IDR",
                                      decimalDigits: 0,
                                      symbol: "Rp ")
                                  .format(snapshot.data.data()['amount']),
                              style: knumberText,
                            );
                          } else {
                            return SpinKitFadingCircle(
                              color: Colors.white,
                              size: 30,
                            );
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
                                      builder: (context) => FutureBuilder<
                                              FineUser>(
                                          future:
                                              FineUserServices.getUser(userId),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return IncomeScreen(
                                                  userId, snapshot.data.amount);
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
                                      builder: (context) => FutureBuilder<
                                              FineUser>(
                                          future:
                                              FineUserServices.getUser(userId),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return SpendingScreen(
                                                  userId, snapshot.data.amount);
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ReportScreen()));
                                },
                                child: ActivitiesWidget(
                                  icon: Icons.pie_chart_rounded,
                                  text: "Reports",
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        // NOTE: LAST TRANSACTIONS
                        Text('Transactions',
                            style:
                                ksecondaryText.copyWith(color: Colors.black)),
                        SizedBox(
                          height: 16,
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: AmountServices.getLastTransactions(userId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final transactions = snapshot.data.docs.take(3);
                              List<TransactionWidget> transactionlist = [];
                              for (var transaction in transactions) {
                                final text = transaction.data()['category'];
                                final int amount = transaction.data()['amount'];
                                final isIncome = transaction.data()['isIncome'];
                                transactionlist.add(TransactionWidget(
                                  text: text,
                                  amount: amount,
                                  isIncome: isIncome,
                                ));
                              }
                              return Column(
                                children: transactionlist,
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else {
                              return Container(
                                child: Text(
                                  "You don't have any transactions",
                                  style: ksecondaryText.copyWith(
                                      color: Colors.black),
                                ),
                              );
                            }
                          },
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
