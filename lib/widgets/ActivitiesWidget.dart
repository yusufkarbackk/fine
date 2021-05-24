part of 'widgets.dart';

class ActivitiesWidget extends StatelessWidget {
  final String text;
  final IconData icon;

  ActivitiesWidget({this.text, this.icon});
  @override
  Widget build(BuildContext context) {
    return (Container(
      padding: EdgeInsets.symmetric(
        vertical: 26,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(color: Colors.grey, spreadRadius: 3, blurRadius: 4),
          ]),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 35,
              height: 35,
              child: Icon(
                icon,
                size: 32,
              ),
            ),
            SizedBox(height: 12),
            Text(text, style: ksecondaryText.copyWith(color: Colors.black, fontSize: 14))
          ],
        ),
      ),
    ));
  }
}
