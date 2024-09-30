import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  TextEditingController? controller;
  String labelText;
  final FormFieldValidator<String> validator;

  // ignore: use_key_in_widget_constructors
  CustomTextfield({
    required this.controller,
    required this.labelText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration:  InputDecoration(
        border: OutlineInputBorder(),
        label: Text(
          labelText,
          style: TextStyle(color: Colors.white),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      validator:validator,
    );
  }
}
