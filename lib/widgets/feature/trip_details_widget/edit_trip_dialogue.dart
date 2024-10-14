// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:wanderlust/models/trip.dart';
// import 'package:wanderlust/service/trip_service.dart';
// import 'package:wanderlust/utils/colors.dart';
// import 'package:wanderlust/widgets/global/custom_snackbar.dart';
// import 'package:wanderlust/widgets/global/custom_text.dart';
// import 'package:wanderlust/widgets/global/custom_textfield.dart';

// class EditTripDialogue extends StatefulWidget {
//   final int index;
//   final Trip trip;
//   final TripService tripService;
//   //final Function onUpdate;

//   EditTripDialogue(
//       {required this.trip,
//       required this.index,
//       // required this.onUpdate,
//       required this.tripService,
//       super.key});

//   @override
//   State<EditTripDialogue> createState() => _EditTripDialogueState();
// }

// class _EditTripDialogueState extends State<EditTripDialogue> {
//   // final TripService _tripService = TripService();
//   @override
//   Widget build(BuildContext context) {
//     final placeController = TextEditingController(text: widget.trip.title);
//     final countryController = TextEditingController(text: widget.trip.country);
//     final descriptionController =
//         TextEditingController(text: widget.trip.description);
//     final budgetController =
//         TextEditingController(text: widget.trip.budget.toString());
//     final travellorsController =
//         TextEditingController(text: widget.trip.travellorCount.toString());
//     File? updatedImage = File(widget.trip.destinationImage);
//     DateTimeRange dateRange =
//         DateTimeRange(start: widget.trip.startDate, end: widget.trip.endDate);
//     return AlertDialog(
//       backgroundColor: primaryColor,
//       title: const CustomText(text: 'Edit Trip Details'),
//       content: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 10),
//             GlobalTextField(
//               controller: placeController,
//               labelText: 'Place',
//               prefixIcon: Icons.place,
//             ),
//             const SizedBox(height: 10),
//             GlobalTextField(
//               controller: countryController,
//               labelText: 'Country',
//               prefixIcon: Icons.flag,
//             ),
//             const SizedBox(height: 10),
//             GlobalTextField(
//               controller: descriptionController,
//               labelText: 'Description',
//               maxLines: 3,
//               prefixIcon: Icons.description,
//             ),
//             const SizedBox(height: 10),
//             GlobalTextField(
//               controller: budgetController,
//               labelText: 'Budget',
//               keyboardType: TextInputType.number,
//               prefixIcon: Icons.money,
//             ),
//             const SizedBox(height: 10),
//             GlobalTextField(
//               controller: travellorsController,
//               labelText: 'No of Travelers',
//               keyboardType: TextInputType.number,
//               prefixIcon: Icons.group,
//             ),
//             const SizedBox(height: 10),
//             const Row(
//               children: [
//                 Icon(
//                   Icons.date_range_outlined,
//                   color: blue,
//                 ),
//                 SizedBox(width: 5),
//                 CustomText(
//                     text: 'Select the dates', fontWeight: FontWeight.bold)
//               ],
//             ),
//             const SizedBox(height: 5),
//             Row(
//               children: [
//                 const SizedBox(width: 5),
//                 TextButton(
//                     onPressed: () async {
//                       DateTimeRange? newDateRange = await showDateRangePicker(
//                         context: context,
//                         initialDateRange: dateRange,
//                         firstDate: DateTime(2024),
//                         lastDate: DateTime(2050),
//                       );

//                       if (newDateRange == null) {
//                         return;
//                       }
//                       setState(() => dateRange = newDateRange);
//                     },
//                     style: TextButton.styleFrom(backgroundColor: Colors.white),
//                     child: CustomText(
//                       text:
//                           '${DateFormat('dd-MM-yyyy').format(dateRange.start)}',
//                       color: blue,
//                     )),
//                 const SizedBox(width: 10),
//                 TextButton(
//                     onPressed: () async {
//                       DateTimeRange? newDateRange = await showDateRangePicker(
//                         context: context,
//                         initialDateRange: dateRange,
//                         firstDate: DateTime(2024),
//                         lastDate: DateTime(2050),
//                       );

//                       if (newDateRange == null) {
//                         return;
//                       }
//                       setState(() => dateRange = newDateRange);
//                     },
//                     style: TextButton.styleFrom(backgroundColor: Colors.white),
//                     child: CustomText(
//                       text: '${DateFormat('dd-MM-yyyy').format(dateRange.end)}',
//                       color: Colors.blue,
//                     ))
//               ],
//             ),
//             const SizedBox(height: 10),
//             Container(
//               height: 110,
//               width: double.maxFinite,
//               decoration: BoxDecoration(
//                 color: primaryColor,
//                 border: Border.all(color: Colors.white),
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: GestureDetector(
//                 onTap: () async {
//                   final pickedFile = await ImagePicker()
//                       .pickImage(source: ImageSource.gallery);
//                   setState(() {
//                     updatedImage = File(pickedFile!.path);
//                   });
//                 },
//                 child: ClipRRect(
//                     borderRadius: BorderRadius.circular(5),
//                     child: Image.file(
//                       updatedImage,
//                       fit: BoxFit.cover,
//                     )),
//               ),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: CustomText(text: 'Cancel')),
//         TextButton(
//             onPressed: () async {
//               final updatedTrip = Trip(
//                 title: placeController.text,
//                 description: descriptionController.text,
//                 budget: int.parse(budgetController.text),
//                 startDate: dateRange.start,
//                 endDate: dateRange.end,
//                 travellorCount: int.parse(travellorsController.text),
//                 country: countryController.text,
//                 destinationImage: updatedImage!.path,
//               );
//               await widget.tripService.updateTrip(widget.index, updatedTrip);
//               Navigator.pop(context);
//               customSnackBar(context, 'Trip updated succesfully');
//               await widget.tripService.getTripDetails();
//             },
//             child: const CustomText(text: 'Update Trip')),
//       ],
//     );
//   }
// }
