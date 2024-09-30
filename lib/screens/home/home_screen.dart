import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/models/user.dart';
import 'package:wanderlust/screens/pages/addtrip_screen.dart';
import 'package:wanderlust/screens/pages/favtrips_screen.dart';
import 'package:wanderlust/screens/pages/homepage_screen.dart';
import 'package:wanderlust/screens/pages/profile/profile_screen.dart';
import 'package:wanderlust/service/signup_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> pages = const [
    HomepageScreen(),
    AddtripScreen(),
    FavtripsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
   // double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryColor,
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: GNav(
              onTabChange: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              selectedIndex: currentIndex,
              color: Colors.white,
              backgroundColor: primaryColor,
              activeColor: Colors.blue,
              gap: screenWidth * 0.015,
              tabBackgroundColor: Colors.grey.shade300,
              padding: const EdgeInsets.all(14),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.map,
                  text: 'Plan Trip',
                ),
                GButton(
                  icon: Icons.favorite,
                  text: 'Liked',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                )
              ]),
        ),
      ),
    );
  }
}
