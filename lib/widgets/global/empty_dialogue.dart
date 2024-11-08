import 'package:flutter/material.dart';

// used for showing no details added
class EmptyDialogue extends StatelessWidget {
  final String imagePath;
  final String text;
  final double topPadding;
  const EmptyDialogue({
    required this.imagePath,
    required this.text,
    this.topPadding = 100,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: topPadding, right: 40, left: 40, bottom: 10),
            child: Image.asset(imagePath),
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(
                color: Colors.white70,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
