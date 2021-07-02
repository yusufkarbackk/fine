part of 'widgets.dart';

class BalanceSection extends StatelessWidget {
  const BalanceSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Align(
      alignment: Alignment.center,
      child: StreamBuilder<DocumentSnapshot>(
          stream: FineUserServices.getUserBalance(user.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.data()['amount'] < 0) {
                return Text(
                  NumberFormat.currency(
                          locale: "id_IDR", decimalDigits: 0, symbol: "Rp ")
                      .format(snapshot.data.data()['amount']),
                  style: knumberText.copyWith(color: Colors.red[600]),
                );
              }
              return Text(
                NumberFormat.currency(
                        locale: "id_IDR", decimalDigits: 0, symbol: "Rp ")
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
    );
  }
}
