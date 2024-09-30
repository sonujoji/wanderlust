import 'package:flutter/material.dart';

class GlobalTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final FormFieldValidator<String> validator;

  // ignore: use_key_in_widget_constructors
  const GlobalTextField({
    required this.controller,
    required this.labelText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(
          labelText,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      validator: validator,
    );
  }
}
