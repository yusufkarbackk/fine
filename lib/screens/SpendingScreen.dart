part of 'screens.dart';

class SpendingScreen extends StatefulWidget {
  final String id;
  final int amount;
  SpendingScreen(this.id, this.amount);
  @override
  _SpendingScreenState createState() => _SpendingScreenState();
}

class _SpendingScreenState extends State<SpendingScreen> {
  final TextEditingController amountController = TextEditingController();
  String categoryValue = 'Shopping';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return;
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 24),
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Enter Your Spending",
                    style: ksecondaryText.copyWith(color: Colors.red)),
                SizedBox(
                  height: 18,
                ),
                TextFieldWidget(
                  controller: amountController,
                  inputType: TextInputType.number,
                  labelText: "Spending Amount",
                  borderSide: BorderSide(color: Colors.red[600]),
                  labelStyle: TextStyle(color: Colors.red),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Spending Category",
                          style: ksecondaryText.copyWith(
                              color: Colors.black, fontSize: 14)),
                      DropdownButton<String>(
                        value: categoryValue,
                        items: [
                          'Foods & Baverages',
                          'Transportation',
                          'Entertainment',
                          'Shopping'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            categoryValue = newValue;
                          });
                        },
                      ),
                    ]),
                SizedBox(height: 52),
                RaisedButton(
                  onPressed: () async {
                    if (amountController.text == "") {
                      Flushbar(
                        duration: Duration(seconds: 4),
                        flushbarPosition: FlushbarPosition.TOP,
                        backgroundColor: Color(0xFFFF5C83),
                        message: 'Please insert your spending amount',
                      )..show(context);
                    } else {
                      int amount = int.tryParse(amountController.text);
                      TransactionModel transaction = TransactionModel(
                          amount: amount,
                          category: categoryValue,
                          isIncome: false,
                          time: DateTime.now(),
                          userId: widget.id);

                      await AmountServices.addUserTransaction(transaction);
                      await FineUserServices.updateUserBalance(
                          transaction.userId, transaction.amount,
                          lastAmount: widget.amount,
                          isIncome: transaction.isIncome);

                      Navigator.pop(context);
                    }
                  },
                  color: Colors.red[400],
                  child: Center(
                    child: Text("Continue", style: ksecondaryText),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
