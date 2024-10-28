import 'package:flutter/material.dart';
import 'package:wanderlust/utils/colors.dart';

class CustomFloatingButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  // final String heroTag;

  const CustomFloatingButton(
      {this.icon = Icons.add,
      required this.onPressed,
      // required this.heroTag,
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
