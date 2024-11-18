import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/feature/bottom_navbar/bottom_navbar.dart';
import 'package:wanderlust/widgets/global/custom_snackbar.dart';
import 'package:wanderlust/widgets/global/custom_textfield.dart';
import 'package:wanderlust/service/trip_service.dart';

class AddTripPage extends StatefulWidget {
  const AddTripPage({super.key});

  @override
  State<AddTripPage> createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  late TextEditingController titleController;
  late TextEditingController countryController;
  late TextEditingController descController;
  late TextEditingController budgetController;

  final TripService _tripService = TripService();
  double currentSliderValue = 1;
  File? selectedImage;
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );
  @override
  void initState() {
    titleController = TextEditingController();
    countryController = TextEditingController();
    descController = TextEditingController();
    budgetController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    countryController.dispose();
    budgetController.dispose();
    super.dispose();
  }

  void setImage(File image) {
    setState(() {
      selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  createNewTrip();
                },
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text(
                  'Add Trip',
                  style: TextStyle(color: Colors.white),
                )),
            const SizedBox(width: 10),
          ],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              )),
          backgroundColor: primaryColor,
          title: const Text(
            'Create Trip',
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 15),
            GlobalTextField(
              controller: titleController,
              labelText: 'Place',
              prefixIcon: Icons.place_outlined,
            ),
            const SizedBox(height: 15),
            GlobalTextField(
                controller: countryController,
                labelText: 'Country',
                prefixIcon: Icons.flag),
            const SizedBox(height: 15),
            SizedBox(
              height: 80,
              child: GlobalTextField(
                controller: descController,
                labelText: 'Description',
                maxLines: 3,
                expand: true,
                prefixIcon: Icons.notes_rounded,
              ),
            ),
            const SizedBox(height: 15),
            GlobalTextField(
              prefixIcon: Icons.currency_rupee,
              controller: budgetController,
              labelText: 'Budget',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Select Dates',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        pickDateRange();
                      },
                      label: Text(
                        '${start.day}/${start.month}/${start.year}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(backgroundColor: Colors.blue),
                    ),
                    const SizedBox(width: 20),
                    TextButton.icon(
                      onPressed: () {
                        pickDateRange();
                      },
                      label: Text(
                        '${end.day}/${end.month}/${end.year}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(backgroundColor: Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Icon(
                  Icons.people,
                  color: Colors.blue,
                ),
                SizedBox(width: 5),
                Text(
                  'No of travellors',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
            const SizedBox(height: 10),
            Slider(
                value: currentSliderValue,
                max: 20,
                divisions: 20,
                label: currentSliderValue.toString(),
                activeColor: Colors.blue,
                onChanged: (value) {
                  setState(() {
                    currentSliderValue = value;
                  });
                }),
            const SizedBox(height: 20),
            const Row(
              children: [
                Icon(
                  Icons.image,
                  color: Colors.blue,
                ),
                SizedBox(width: 5),
                Text(
                  'Add image of your destination',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  File? pickedImage = await pickImage();
                  if (pickedImage != null) {
                    setImage(pickedImage);
                  }
                },
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(5)),
                  child: selectedImage != null
                      ? ClipRRect(
                          child: Image.file(selectedImage!, fit: BoxFit.cover),
                        )
                      : const Icon(
                          Icons.add_photo_alternate,
                          color: Colors.blue,
                          size: 40,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> createNewTrip() async {
    if (titleController.text.isEmpty ||
        descController.text.isEmpty ||
        budgetController.text.isEmpty ||
        countryController.text.isEmpty ||
        dateRange.end == DateTime.now() ||
        currentSliderValue < 1) {
      customSnackBar(context, 'Please fill all the fields');
      return;
    }

    if (dateRange.end == DateTime.now()) {
      customSnackBar(context, 'Select the trip dates');
      return;
    }
    if (currentSliderValue < 1) {
      customSnackBar(context, 'Select the number of travellors');
      return;
    }
    if (selectedImage?.path == null) {
      customSnackBar(context, 'Add an image for your trip');
      return;
    }

    String budgetText = budgetController.text.trim();
    if (budgetText.isEmpty || int.tryParse(budgetText) == null) {
      customSnackBar(context, 'Please enter a valid budget');
      return;
    }

    int budget = int.parse(budgetText);

    final newTrip = Trip(
      title: titleController.text,
      description: descController.text,
      budget: budget,
      startDate: dateRange.start,
      endDate: dateRange.end,
      travellorCount: currentSliderValue.round(),
      country: countryController.text,
      destinationImage: selectedImage!.path,
    );
    await _tripService.addTrip(newTrip);

    log(newTrip.title);
    print(newTrip.destinationImage);

    customSnackBar(context, 'Trip added succesfully');

    tripListNotifier.value = [...tripListNotifier.value];

    // _tripService.getTripDetails();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      // firstDate: DateTime(2024),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (newDateRange == null) {
      return;
    }
    setState(() => dateRange = newDateRange);
  }

  Future<File?> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }
}
