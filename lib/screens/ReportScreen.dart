part of 'screens.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    User userId = Provider.of<User>(context);
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return;
      },
      child: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: StreamBuilder<QuerySnapshot>(
                    stream: AmountServices.getAllTransactions(userId.uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final transactions = snapshot.data.docs;
                        Map<String, double> reportData =
                            AmountServices.mappingTransactions(transactions);

                        return PieChart(
                          dataMap: reportData,
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: 32,
                          chartRadius: MediaQuery.of(context).size.width * 0.75,
                          initialAngleInDegree: 0,
                          chartType: ChartType.disc,
                          ringStrokeWidth: 32,
                          legendOptions: LegendOptions(
                            showLegendsInRow: false,
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
