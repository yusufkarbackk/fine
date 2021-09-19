part of 'screens.dart';

class ReportScreen extends StatefulWidget {
  final String userId;
  ReportScreen(this.userId);
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String month = DateFormat('MMMM').format(DateTime.now());
  bool isAll = false;
  var transactionsChecker;
  @override
  Widget build(BuildContext context) {
    User userId = Provider.of<User>(context);
    isAll
        ? transactionsChecker = AmountServices.getAllTransactions(userId.uid)
        : transactionsChecker =
            AmountServices.getTransactionsByMonth(month, userId.uid);
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return;
      },
      child: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            Stack(children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        size: 28,
                      ),
                    )),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text("Report screen",
                          style: ksecondaryText.copyWith(color: Colors.black))))
            ]),
            DropdownButton<String>(
              value: month,
              items: [
                'January',
                'February',
                'March',
                'April',
                'May',
                'June',
                'July',
                'August',
                'September',
                'October',
                'November',
                'December',
                'All'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  month = newValue;
                  if (month == 'All') {
                    isAll = true;
                    transactionsChecker =
                        AmountServices.getAllTransactions(userId.uid);
                  } else {
                    isAll = false;
                    transactionsChecker = AmountServices.getTransactionsByMonth(
                        month, userId.uid);
                  }
                });
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: StreamBuilder<QuerySnapshot>(
                    stream: transactionsChecker,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final transactions = snapshot.data.docs;

                        Map<String, double> reportData =
                            AmountServices.mappingTransactions(transactions);

                        return PieChart(
                          dataMap: reportData,
                          animationDuration: Duration(milliseconds: 1000),
                          chartLegendSpacing: 32,
                          chartRadius: MediaQuery.of(context).size.width / 2,
                          initialAngleInDegree: 0,
                          chartType: ChartType.disc,
                          ringStrokeWidth: 32,
                          legendOptions: LegendOptions(
                            showLegendsInRow: true,
                            legendPosition: LegendPosition.bottom,
                            showLegends: true,
                            legendShape: BoxShape.circle,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: true,
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: true,
                          ),
                        );
                      } else if (!snapshot.hasData) {
                        return SpinKitFadingCircle(
                          color: kmainColor,
                          size: 50,
                        );
                      } else {
                        return Text("Error getting data");
                      }
                    }),
              ),
            )
          ],
        ),
      )),
    );
  }
}
