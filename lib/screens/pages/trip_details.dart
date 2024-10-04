import 'package:flutter/material.dart';
import 'package:wanderlust/utils/colors.dart';

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
          title: Text(
            'Trips Stats',
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Center(
          child: Text(
            'Trip details',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ));
  }
}
