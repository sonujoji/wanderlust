import 'package:flutter/material.dart';
import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/service/trip_service.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/feature/completed_trips/completed_tile.dart';
import 'package:wanderlust/widgets/feature/completed_trips/completed_trip_details.dart';
import 'package:wanderlust/widgets/global/empty_dialogue.dart';

class CompletedTripsScreen extends StatefulWidget {
  const CompletedTripsScreen({super.key});

  @override
  State<CompletedTripsScreen> createState() => _CompletedTripsScreenState();
}

class _CompletedTripsScreenState extends State<CompletedTripsScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: tripListNotifier,
      builder: (BuildContext context, List<Trip> trips, Widget? child) {
        final completedTrips =
            trips.where((trip) => trip.isCompleted == true).toList();
        return Scaffold(
            backgroundColor: primaryColor,
            appBar: AppBar(
              backgroundColor: primaryColor,
              centerTitle: true,
              title: Text(
                'Completed Trips',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(15),
              child: completedTrips.isNotEmpty
                  ? ListView.builder(
                      itemCount: completedTrips.length,
                      itemBuilder: (context, index) {
                        final trip = completedTrips[index];
                        return GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => 
                                          CompletedTripDetails(tripId: trip.id.toString(),trip: trip,)));
                            },
                            child:
                                CompletedTripsTile(trip: trip, index: index));
                      })
                  : EmptyDialogue(
                  
                      imagePath: 'assets/images/Traveling-rafiki.png',
                      text: "You haven't completed any trips "),
            ));
      },
    );
  }
}
