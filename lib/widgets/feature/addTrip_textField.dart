import 'package:flutter/material.dart';

class AddTripTextField extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final String label;
  final String hintText;


  AddTripTextField({
    required this.label,
    required this.hintText,
  
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
        border: const OutlineInputBorder(),
        label: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      
    );
  }
}
