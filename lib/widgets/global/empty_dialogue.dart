import 'package:flutter/material.dart';
// used for showing no details added 
class EmptyDialogue extends StatelessWidget {
  final String imagePath;
  final String text;
  const EmptyDialogue({
  required this.imagePath,
  required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
              children: [
      Padding(
        padding: const EdgeInsets.only(
            top: 100, right: 30, left: 30, bottom: 10),
        child: Image.asset(imagePath),
      ),
      const SizedBox(height: 10),
      Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      )
              ],
            ),
    );
  }
}
