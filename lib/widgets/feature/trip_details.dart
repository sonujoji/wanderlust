import 'package:flutter/material.dart';
import 'package:wanderlust/utils/colors.dart';

class TripDetails extends StatelessWidget {
  const TripDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: primaryColor,
          body: Stack(
            children: [
              ClipRRect(
                  child: Image.asset(
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      'assets/images/pexels-pixabay-237272.jpg')),
              Positioned(
                bottom: 0,
                left: 80,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Manali, India',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
