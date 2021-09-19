part of 'screens.dart';

class HomeScreen extends StatelessWidget {
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
                  HeaderSection(),
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
                  // NOTE: BALANCE SECTION
                  BalanceSection(),
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
                        ActivitiesSection(),
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
                        TransactionsSection()
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
