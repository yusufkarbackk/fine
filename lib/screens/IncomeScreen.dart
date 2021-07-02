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
      onWillPop: () async {
        Navigator.pop(context);
        return true;
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
                  labelText: "Income Amount",
                  borderSide: BorderSide(color: Colors.green[600]),
                  labelStyle: TextStyle(color: Colors.green),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Income Category",
                          style: ksecondaryText.copyWith(
                              color: Colors.black, fontSize: 14)),
                      DropdownButton<String>(
                        value: categoryValue,
                        items: ['Salary', 'Gifts', 'Payback', 'Investment']
                            .map((String value) {
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
                        message: 'Please insert your income amount',
                      )..show(context);
                    } else {
                      int amount = int.tryParse(amountController.text) ?? 0;
                      String notFormatedMonth =
                          DateFormat('MMMM').format(DateTime.now());

                      TransactionModel transaction = TransactionModel(
                          amount: amount,
                          category: categoryValue,
                          isIncome: true,
                          time: DateTime.now(),
                          month: notFormatedMonth,
                          userId: widget.id);

                      await AmountServices.addUserTransaction(transaction);
                      await FineUserServices.updateUserBalance(
                          transaction.userId, transaction.amount,
                          lastAmount: widget.amount,
                          isIncome: transaction.isIncome);

                      Navigator.pop(context);
                    }
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
