part of 'widgets.dart';

class TransactionWidget extends StatelessWidget {
  final String text;
  final int amount;
  final bool isIncome;

  TransactionWidget({
    this.text,
    this.amount,
    this.isIncome,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    child: CircleAvatar(
                        backgroundColor:
                            isIncome ? Colors.lightGreen : Colors.red,
                        child: Center(
                          child: Icon(
                            isIncome
                                ? Icons.arrow_upward_rounded
                                : Icons.arrow_downward_rounded,
                            size: 28,
                            color: Colors.white,
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(text,
                      style: ksecondaryText.copyWith(
                          color: Colors.black, fontSize: 14))
                ],
              ),
              Text(
                  NumberFormat.currency(
                          locale: "id_IDR", decimalDigits: 0, symbol: "Rp ")
                      .format(amount),
                  style: knumberText.copyWith(
                      color: isIncome ? Colors.lightGreen : Colors.red,
                      fontSize: 14))
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
