import 'package:flutter/material.dart';
import 'package:wanderlust/utils/colors.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/wanderlustLogo.jpg',
                  height: screenHeight * 0.050,
                ),
              ),
              SizedBox(width: screenWidth * 0.040),
              const Text(
                'Wanderlust',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: Text(
            'home',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ));
  }
}
