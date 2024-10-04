import 'package:flutter/material.dart';

class GlobalTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final int? maxLines;
  final bool? expand;
  final IconData? prefixIcon;

  // ignore: use_key_in_widget_constructors
  const GlobalTextField({
    required this.controller,
    required this.labelText,
    this.maxLines,
    this.expand,
    this.validator,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      expands: false,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white60)),
        border: const OutlineInputBorder(),
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.blue,
        ),
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
