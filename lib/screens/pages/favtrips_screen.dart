import 'package:flutter/material.dart';
import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/service/trip_service.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/feature/addFavorites/favorite_componet.dart';
import 'package:wanderlust/widgets/global/custom_text.dart';
import 'package:wanderlust/widgets/global/empty_dialogue.dart';

class FavtripsScreen extends StatefulWidget {
  const FavtripsScreen({super.key});

  @override
  State<FavtripsScreen> createState() => _FavtripsScreenState();
}

class _FavtripsScreenState extends State<FavtripsScreen> {
  final TripService _tripService = TripService();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: tripListNotifier,
      builder: (BuildContext cxt, List<Trip> trips, Widget? child) {
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
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  
                  Expanded(
                      child: ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return FavoriteComponent();
                          }))
                ],
              ),
            )
          
            // EmptyDialogue(
            //     imagePath: 'assets/images/fav-image.png',
            //     text: "You haven't liked any trips"),
            );
      },
    );
  }
}
