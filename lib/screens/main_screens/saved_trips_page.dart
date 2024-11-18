import 'package:flutter/material.dart';
import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/screens/sub_screens/trip_details_page.dart';
import 'package:wanderlust/service/trip_service.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/feature/saved_trips_components.dart.dart';
import 'package:wanderlust/widgets/global/custom_appbar.dart';
import 'package:wanderlust/widgets/global/empty_dialogue.dart';

class SavedTrips extends StatefulWidget {
  const SavedTrips({super.key});

  @override
  State<SavedTrips> createState() => _SavedTripsState();
}

class _SavedTripsState extends State<SavedTrips> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: tripListNotifier,
      builder: (BuildContext cxt, List<Trip> trips, Widget? child) {
        final savedTrips = trips.where((trip) => trip.isFavorite).toList();
        return Scaffold(
            backgroundColor: primaryColor,
            appBar: CustomAppbar(title: 'Saved Trips'),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: savedTrips.isNotEmpty
                        ? ListView.builder(
                            itemCount:
                                trips.where((trip) => trip.isFavorite).length,
                            itemBuilder: (context, index) {
                              final trip = savedTrips[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TripDetailsScreen(trip: trip)));
                                },
                                child: SavedTripsComponent(
                                  trip: trip,
                                  index: index,
                                ),
                              );
                            })
                        : EmptyDialogue(
                            imagePath: 'assets/images/fav-image.png',
                            text: "You haven't liked any trips"),
                  )
                ],
              ),
            ));
      },
    );
  }
}
