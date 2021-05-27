part of 'widgets.dart';

class CategoryDropdown extends StatefulWidget {
  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  String categoryValue = 'Salary';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
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
    );
  }
}
