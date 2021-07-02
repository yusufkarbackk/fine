part of 'widgets.dart';

class TransactionsSection extends StatelessWidget {
  const TransactionsSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<QuerySnapshot>(
      stream: AmountServices.getLastTransactions(user.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.docs.length == 0) {
            return Container(
              child: Text(
                "You don't have any transactions",
                style: ksecondaryText.copyWith(color: Colors.black),
              ),
            );
          } else {
            final transactions = snapshot.data.docs.take(3);
            List<TransactionWidget> transactionlist = [];
            for (var transaction in transactions) {
              final text = transaction.data()['category'];
              final int amount = transaction.data()['amount'];
              final isIncome = transaction.data()['isIncome'];
              final DateTime epoch = DateTime.fromMillisecondsSinceEpoch(
                  transaction.data()['time']);
              final date = DateFormat("EEE, M/d/y").format(epoch);
              transactionlist.add(TransactionWidget(
                text: text,
                amount: amount,
                isIncome: isIncome,
                dateString: date,
              ));
            }
            return Column(
              children: transactionlist,
            );
          }
        } else {
          return Container(
            child: Text(
              "You don't have any transactions",
              style: ksecondaryText.copyWith(color: Colors.black),
            ),
          );
        }
      },
    );
  }
}
