import 'package:flutter/foundation.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double horizontalPadding = screenWidth * 0.3;
    final double topPaddingValue = topPadding * 0.3;
    final double imageHeight = screenHeight * 0.3;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: kIsWeb ? topPaddingValue : topPadding,
                right: kIsWeb ? horizontalPadding : 40,
                left: kIsWeb ? horizontalPadding : 40,
                bottom: kIsWeb ? topPaddingValue : 10),
            child: Image.asset(
              imagePath,
              height: imageHeight,
              fit: BoxFit.contain,
            ),
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
