import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {super.key,
      this.isPassword = false,
      required this.label,
      required this.controller,
      required this.prefix,
      this.validator});
  bool isPassword;
  String label;
  IconData prefix;
  TextEditingController controller = TextEditingController();
  String? Function(String?)? validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          validator: widget.validator,
          controller: widget.controller,
          obscureText: widget.isPassword == false ? !isObscure : isObscure,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: Text(widget.label),
              prefixIcon: Icon(widget.prefix),
              suffixIcon: widget.isPassword == true
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      child: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off))
                  : null)),
    );
  }
}
