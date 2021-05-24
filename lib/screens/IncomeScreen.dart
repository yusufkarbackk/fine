part of 'screens.dart';

class IncomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        TransactionWidget(
          amount: 100000,
          text: "Food & Baverages",
        );
        return;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey,
          body: Column(
            children: [
              Text("Enter Your Income", style: TextStyle(color: Colors.white)),
              SizedBox(
                height: 18,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: ListView(
                    children: [
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "Add Income",
                            focusColor: Colors.teal,
                            filled: true),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
