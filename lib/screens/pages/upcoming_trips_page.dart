import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/widgets/feature/floating_action_button/add_trip_button.dart';
import 'package:wanderlust/service/trip_service.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/feature/trip_details_components/delete_trip_dialogue.dart';
import 'package:wanderlust/widgets/feature/trip_details_components/edit_trip_dialogue.dart';
import 'package:wanderlust/widgets/feature/trip_details_components/trip_details_page.dart';
import 'package:wanderlust/widgets/feature/trip_details_components/upcoming_trip_tile.dart';
import 'package:wanderlust/widgets/global/custom_text.dart';
import 'package:wanderlust/widgets/global/empty_dialogue.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  late TextEditingController placeController;
  late TextEditingController countryController;
  late TextEditingController descriptionController;
  late TextEditingController travellorsController;
  late TextEditingController budgetController;

  final TripService _tripService = TripService();
  File? updatedImage;
  @override
  void initState() {
    super.initState();
    placeController = TextEditingController();
    countryController = TextEditingController();
    descriptionController = TextEditingController();
    travellorsController = TextEditingController();
    budgetController = TextEditingController();
    // _tripService.getTripDetails();

    //fetch trip status
    _tripService.getTripDetails().then((_) {
      for (int i = 0; i < tripListNotifier.value.length; i++) {
        updateTripStatus(tripListNotifier.value[i], i);
      }
    });
  }

  @override
  void dispose() {
    placeController.dispose();
    countryController.dispose();
    descriptionController.dispose();
    travellorsController.dispose();
    budgetController.dispose();
    super.dispose();
  }

  // Future<void> _handleRefresh() async {
  //   await Future.delayed(Duration(seconds: 3));
  // }

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;

    return ValueListenableBuilder(
      valueListenable: tripListNotifier,
      builder: (BuildContext cxt, List<Trip> trips, Widget? child) {
        final upcommingTrips =
            trips.where((trip) => trip.isCompleted == false).toList();
        return Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: const Text(
              'Your Trips',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: true,
          ),
          floatingActionButton: const FloatingButton(),
          body: upcommingTrips.isEmpty
              ? const EmptyDialogue(
                  imagePath: 'assets/images/Journey-amico.png',
                  text: "You haven't added any trips")
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: 'Upcoming Trips,',
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: upcommingTrips.length,
                          itemBuilder: (context, index) {
                            final trip = upcommingTrips[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Slidable(
                                endActionPane: ActionPane(
                                    motion: const StretchMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          //edit dialogue
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  EditTripDialog(
                                                      trip: trip,
                                                      index: index));
                                        },
                                        backgroundColor: primaryColor,
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit,
                                      ),
                                      SlidableAction(
                                        onPressed: (context) {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  //delete dialogue
                                                  DeleteTripDialogue(
                                                    index: index,
                                                    onDelete: (index) =>
                                                        _tripService
                                                            .deleteTrip(index),
                                                  ));
                                        },
                                        backgroundColor: primaryColor,
                                        foregroundColor: Colors.red,
                                        icon: Icons.delete,
                                      )
                                    ]),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TripDetailsScreen(
                                                  trip: trip,
                                                )));
                                  },
                                  child: ListUpcomingTrips(
                                    trip: trip,
                                    index: index,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  void checkTripStatus(Trip trip) {
    DateTime currentDate = DateTime.now();
    if (trip.endDate.isAfter(currentDate)) {
      trip.isCompleted = false;
    } else {
      trip.isCompleted = true;
    }
  }

  void updateTripStatus(Trip trip, int index) async {
    checkTripStatus(trip);
    await _tripService.updateTrip(index, trip);
  }
}
