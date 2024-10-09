import 'package:flutter/material.dart';
import 'package:wanderlust/utils/colors.dart';

class FavtripsScreen extends StatefulWidget {
  const FavtripsScreen({super.key});

  @override
  State<FavtripsScreen> createState() => _FavtripsScreenState();
}

class _FavtripsScreenState extends State<FavtripsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: const Text(
            'Favorite Trips',
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: const Center(
          child: Text(
            'fav trips',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ));
  }
}
