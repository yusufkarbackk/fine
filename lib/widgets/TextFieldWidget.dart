part of 'widgets.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String labelText;
  final bool isPassword;
  final TextStyle labelStyle;
  final BorderSide borderSide;

  TextFieldWidget(
      {this.controller,
      this.inputType,
      this.labelText,
      this.isPassword = false,
      this.labelStyle,
      this.borderSide});
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
          focusedBorder: OutlineInputBorder(borderSide: borderSide),
          filled: true,
          fillColor: Colors.white,
          labelText: labelText,
          labelStyle: labelStyle,
        ));
  }
}
