import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:wanderlust/screens/pages/trip_details.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/screens/pages/favtrips_screen.dart';
import 'package:wanderlust/screens/pages/homepage_screen.dart';
import 'package:wanderlust/screens/pages/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> pages = const [
    HomepageScreen(),
    TripDetailsScreen(),
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
        decoration:
            BoxDecoration(color: grey, borderRadius: BorderRadius.circular(50)),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: GNav(
              onTabChange: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              selectedIndex: currentIndex,
              color: Colors.white,
              backgroundColor: Colors.transparent,
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
                  text: 'Trip Details',
                ),
                GButton(
                  icon: Icons.favorite,
                  text: 'Favorite',
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
