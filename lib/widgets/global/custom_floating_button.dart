import 'package:flutter/material.dart';
import 'package:wanderlust/utils/colors.dart';

class CustomFloatingButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const CustomFloatingButton(
      {this.icon = Icons.add,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: blue,
      child: Icon(icon),
    );
  }
}
