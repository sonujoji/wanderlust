import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/widgets/feature/trip_details_widget/add_trip.dart';
import 'package:wanderlust/service/trip_service.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:wanderlust/widgets/feature/trip_details_widget/delete_trip_dialogue.dart';
import 'package:wanderlust/widgets/feature/trip_details_widget/upcoming_trips.dart';
import 'package:wanderlust/widgets/global/custom_snackbar.dart';
import 'package:wanderlust/widgets/global/custom_text.dart';
import 'package:wanderlust/widgets/global/custom_textfield.dart';
import 'package:wanderlust/widgets/global/empty_dialogue.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final TripService _tripService = TripService();
  TextEditingController placeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController travellorsController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  File? updatedImage;
  @override
  void initState() {
    super.initState();
    _tripService.getTripDetails();
  }

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    return ValueListenableBuilder(
      valueListenable: tripListNotifier,
      builder: (BuildContext cxt, List<Trip> trips, Widget? child) {
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddTripPage()));
            },
            backgroundColor: Colors.blue,
            child: const Icon(
              Icons.add,
            ),
          ),
          body: trips.isEmpty
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
                          itemCount: trips.length,
                          itemBuilder: (context, index) {
                            final trip = trips[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Slidable(
                                endActionPane: ActionPane(
                                    motion: const StretchMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          //edit dialogue
                                          placeController.text = trip.title;
                                          countryController.text =
                                              trip.country!;
                                          descriptionController.text =
                                              trip.description;
                                          budgetController.text =
                                              trip.budget.toString();
                                          travellorsController.text =
                                              trip.travellorCount.toString();
                                          updatedImage =
                                              File(trip.destinationImage);
                                          DateTimeRange dateRange =
                                              DateTimeRange(
                                            start: trip.startDate,
                                            end: trip.endDate,
                                          );

                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return StatefulBuilder(
                                                builder: (context, setState) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        primaryColor,
                                                    title: const CustomText(
                                                        text:
                                                            'Edit Trip Details'),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(
                                                              height: 10),
                                                          GlobalTextField(
                                                            controller:
                                                                placeController,
                                                            labelText: 'Place',
                                                            prefixIcon:
                                                                Icons.place,
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          GlobalTextField(
                                                            controller:
                                                                countryController,
                                                            labelText:
                                                                'Country',
                                                            prefixIcon:
                                                                Icons.flag,
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          GlobalTextField(
                                                            controller:
                                                                descriptionController,
                                                            labelText:
                                                                'Description',
                                                            maxLines: 3,
                                                            prefixIcon: Icons
                                                                .description,
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          GlobalTextField(
                                                            controller:
                                                                budgetController,
                                                            labelText: 'Budget',
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            prefixIcon:
                                                                Icons.money,
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          GlobalTextField(
                                                            controller:
                                                                travellorsController,
                                                            labelText:
                                                                'No of Travelers',
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            prefixIcon:
                                                                Icons.group,
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          const Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .date_range_outlined,
                                                                color: blue,
                                                              ),
                                                              SizedBox(
                                                                  width: 5),
                                                              CustomText(
                                                                  text:
                                                                      'Select the dates',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Row(
                                                            children: [
                                                              const SizedBox(
                                                                  width: 5),
                                                              TextButton(
                                                                  onPressed:
                                                                      () async {
                                                                    DateTimeRange?
                                                                        newDateRange =
                                                                        await showDateRangePicker(
                                                                      context:
                                                                          context,
                                                                      initialDateRange:
                                                                          dateRange,
                                                                      firstDate:
                                                                          DateTime(
                                                                              2024),
                                                                      lastDate:
                                                                          DateTime(
                                                                              2050),
                                                                    );

                                                                    if (newDateRange ==
                                                                        null) {
                                                                      return;
                                                                    }
                                                                    setState(() =>
                                                                        dateRange =
                                                                            newDateRange);
                                                                  },
                                                                  style: TextButton.styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white),
                                                                  child:
                                                                      CustomText(
                                                                    text:
                                                                        '${DateFormat('dd-MM-yyyy').format(dateRange.start)}',
                                                                    color: blue,
                                                                  )),
                                                              const SizedBox(
                                                                  width: 10),
                                                              TextButton(
                                                                  onPressed:
                                                                      () async {
                                                                    DateTimeRange?
                                                                        newDateRange =
                                                                        await showDateRangePicker(
                                                                      context:
                                                                          context,
                                                                      initialDateRange:
                                                                          dateRange,
                                                                      firstDate:
                                                                          DateTime(
                                                                              2024),
                                                                      lastDate:
                                                                          DateTime(
                                                                              2050),
                                                                    );

                                                                    if (newDateRange ==
                                                                        null) {
                                                                      return;
                                                                    }
                                                                    setState(() =>
                                                                        dateRange =
                                                                            newDateRange);
                                                                  },
                                                                  style: TextButton.styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white),
                                                                  child:
                                                                      CustomText(
                                                                    text:
                                                                        '${DateFormat('dd-MM-yyyy').format(dateRange.end)}',
                                                                    color: Colors
                                                                        .blue,
                                                                  ))
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          Container(
                                                            height: 110,
                                                            width: double
                                                                .maxFinite,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  primaryColor,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .white),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () async {
                                                                final pickedFile =
                                                                    await ImagePicker()
                                                                        .pickImage(
                                                                            source:
                                                                                ImageSource.gallery);
                                                                setState(() {
                                                                  updatedImage =
                                                                      File(pickedFile!
                                                                          .path);
                                                                });
                                                              },
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                child: updatedImage !=
                                                                        null
                                                                    ? Image
                                                                        .file(
                                                                        updatedImage!,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      )
                                                                    : const Center(
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .add_photo_alternate,
                                                                          color:
                                                                              Colors.blue,
                                                                          size:
                                                                              40,
                                                                        ),
                                                                      ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: CustomText(
                                                              text: 'Cancel')),
                                                      TextButton(
                                                          onPressed: () async {
                                                            final updatedTrip =
                                                                Trip(
                                                              title:
                                                                  placeController
                                                                      .text,
                                                              description:
                                                                  descriptionController
                                                                      .text,
                                                              budget: int.parse(
                                                                  budgetController
                                                                      .text),
                                                              startDate:
                                                                  dateRange
                                                                      .start,
                                                              endDate:
                                                                  dateRange.end,
                                                              travellorCount:
                                                                  int.parse(
                                                                      travellorsController
                                                                          .text),
                                                              country:
                                                                  countryController
                                                                      .text,
                                                              destinationImage:
                                                                  updatedImage!
                                                                      .path,
                                                            );
                                                            await _tripService
                                                                .updateTrip(
                                                                    index,
                                                                    updatedTrip);
                                                            Navigator.pop(
                                                                context);
                                                            customSnackBar(
                                                                context,
                                                                'Trip updated succesfully');
                                                            await _tripService
                                                                .getTripDetails();
                                                          },
                                                          child: const CustomText(
                                                              text:
                                                                  'Update Trip')),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          );
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
                                                  DeleteTripDialogue(
                                                    index: index,
                                                    onDelete:(index)=> _tripService
                                                        .deleteTrip(index),
                                                  ));
                                        },
                                        backgroundColor: primaryColor,
                                        foregroundColor: Colors.red,
                                        icon: Icons.delete,
                                      )
                                    ]),
                                child: ListTrips(trip: trip),
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
}
