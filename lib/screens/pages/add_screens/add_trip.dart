import 'package:flutter/material.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/feature/addTrip_textField.dart';
import 'package:wanderlust/widgets/global/custom_button.dart';
import 'package:wanderlust/widgets/global/custom_textfield.dart';

class AddTripPage extends StatefulWidget {
  const AddTripPage({super.key});

  @override
  State<AddTripPage> createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );

  double currentSliderValue = 1;

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
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
          'Add new trip',
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 15),
            GlobalTextField(
              controller: titleController,
              labelText: 'Title',
              prefixIcon: Icons.title_outlined,
            ),
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
                labelText: 'Budget'),
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
            currentSliderValue > 1
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.people,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Select Companions',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        label: const Text(
                          'Pick Companion',
                          style: TextStyle(color: Colors.white),
                        ),
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.blue),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 30),
            CustomElevatedButton(text: 'Add trip', onPressed: () {})
          ],
        ),
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(2024),
      lastDate: DateTime(2050),
    );

    if (newDateRange == null) {
      return;
    }
    setState(() => dateRange = newDateRange);
  }
}
