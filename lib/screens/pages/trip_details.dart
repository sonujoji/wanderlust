import 'package:flutter/material.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/global/empty_dialogue.dart';

class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({super.key});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: const Text(
            'Trips Stats',
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: const EmptyDialogue(
            imagePath: 'assets/images/Traveling-rafiki.png',
            text: "You haven't completed any trips "));
  }
}
