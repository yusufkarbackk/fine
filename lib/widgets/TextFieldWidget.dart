part of 'widgets.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String labelText;
  final bool isPassword;
  final TextStyle labelStyle;
  final BorderSide borderSide;
  final Function onChanged;
  final String hintText;

  TextFieldWidget(
      {this.controller,
      this.inputType,
      this.labelText,
      this.isPassword = false,
      this.labelStyle,
      this.borderSide,
      this.hintText,
      this.onChanged});
  @override
  Widget build(BuildContext context) {
    return TextField(
        onChanged: onChanged,
        obscureText: isPassword,
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          hintText: hintText,
          focusedBorder: OutlineInputBorder(borderSide: borderSide),
          filled: true,
          fillColor: Colors.white,
          labelText: labelText,
          labelStyle: labelStyle,
        ));
  }
}
