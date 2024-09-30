import 'package:flutter/material.dart';
import 'package:wanderlust/utils/colors.dart';

class AddtripScreen extends StatefulWidget {
  const AddtripScreen({super.key});

  @override
  State<AddtripScreen> createState() => _AddtripScreenState();
}

class _AddtripScreenState extends State<AddtripScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(
            'Add Trip',
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Center(
          child: Text(
            'add trip',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ));
  }
}
