part of 'screens.dart';

class IncomeScreen extends StatefulWidget {
  final String id;
  final int amount;
  IncomeScreen(this.id, this.amount);
  @override
  _IncomeScreenState createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  final TextEditingController amountController = TextEditingController();
  String categoryValue = 'Salary';

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
                Text("Enter Your Income",
                    style: ksecondaryText.copyWith(color: Colors.black)),
                SizedBox(
                  height: 18,
                ),
                TextFieldWidget(
                  controller: amountController,
                  inputType: TextInputType.number,
                  labelText: "Amount",
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Income Category",
                          style: ksecondaryText.copyWith(color: Colors.black)),
                      DropdownButton<String>(
                        value: categoryValue,
                        items: ['Salary', 'Gifts'].map((String value) {
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
                    int amount = int.tryParse(amountController.text);
                    TransactionModel transaction = TransactionModel(
                        amount: amount,
                        category: categoryValue,
                        isIncome: true,
                        time: DateTime.now(),
                        userId: widget.id);

                    await AmountServices.addUserTransaction(transaction);
                    await FineUserServices.updateUserBalance(
                        transaction.userId, transaction.amount,
                        lastAmount: widget.amount);

                    Navigator.pop(context);
                  },
                  color: Colors.green[400],
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
