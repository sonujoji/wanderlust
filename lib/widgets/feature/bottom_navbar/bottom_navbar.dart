import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:wanderlust/screens/main_screens/completed_trips_page.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/screens/main_screens/saved_trips_page.dart';
import 'package:wanderlust/screens/main_screens/upcoming_trips_page.dart';
import 'package:wanderlust/screens/main_screens/profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> pages = const [
    HomepageScreen(),
    CompletedTripsScreen(),
    SavedTrips(),
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
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
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
                  icon: Icons.place,
                  text: 'Upcoming',
                ),
                GButton(
                  icon: Icons.map,
                  text: 'Completed',
                ),
                GButton(
                  icon: Icons.bookmark,
                  text: 'Saved',
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
