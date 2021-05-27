part of 'widgets.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String labelText;
  final bool isPassword;

  TextFieldWidget(
      {this.controller,
      this.inputType,
      this.labelText,
      this.isPassword = false});
  @override
  Widget build(BuildContext context) {
    return TextField(
        obscureText: isPassword,
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green[600])),
          filled: true,
          fillColor: Colors.white,
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.green[600]),
        ));
  }
}
