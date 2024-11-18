import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wanderlust/models/trip.dart';
// import 'package:wanderlust/service/iteneraries_service.dart';
import 'package:wanderlust/service/trip_service.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/screens/sub_screens/add_itenerary_page.dart';
import 'package:wanderlust/widgets/global/custom_floating_button.dart';
import 'package:wanderlust/widgets/global/custom_text.dart';
// import 'package:wanderlust/widgets/feature/show_dialogues/itenaray_dialogue.dart';
// import 'package:wanderlust/widgets/feature/trip_details_components/add_itenerary.dart';
// import 'package:wanderlust/widgets/feature/trip_details_components/add_itenerary_page.dart';
// import 'package:wanderlust/widgets/feature/trip_details_components/animated_container.dart';
// import 'package:wanderlust/widgets/global/custom_floating_button.dart';
// import 'package:wanderlust/widgets/global/custom_snackbar.dart';
// import 'package:wanderlust/widgets/global/custom_text.dart';

class ItenararyPage extends StatefulWidget {
  final Trip trip;
  const ItenararyPage({super.key, required this.trip});

  @override
  State<ItenararyPage> createState() => _ItenararyPageState();
}

class _ItenararyPageState extends State<ItenararyPage> {
  Map<String, List<String>> iteneraries = {};

  @override
  void initState() {
    iteneraries = widget.trip.iteneraries ?? {};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Trip trip = widget.trip;

    return ValueListenableBuilder(
      valueListenable: tripListNotifier,
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: primaryColor,
          body: iteneraries.isEmpty
              ? Center(
                  child: CustomText(text: 'No itineraries available'),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: iteneraries.keys.length,
                  itemBuilder: (BuildContext context, int index) {
                    final dateFormat = DateFormat('dd MMM yyyy');
                    List<String> sortedDates = iteneraries.keys.toList()
                      ..sort((a, b) {
                        DateTime dateA = dateFormat.parse(a);
                        DateTime dateB = dateFormat.parse(b);
                        return dateA.compareTo(dateB);
                      });

                    String date = sortedDates[index];
                    List<String> activities = iteneraries[date] ?? [];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Card(
                        color: grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: date,
                                color: blue,
                              ),
                              Divider(color: Colors.white60),
                              ...activities.map(
                                (activity) => ListTile(
                                  leading: Icon(Icons.place, color: blue),
                                  title: CustomText(
                                    text: activity,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
          floatingActionButton: CustomFloatingButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddIteneraryPage(trip: trip),
                ),
              ).then((_) {
                setState(() {
                  iteneraries = widget.trip.iteneraries ?? {};
                });
              });
            },
            icon: Icons.edit,
          ),
        );
      },
    );
  }

  // List<DateTime> getDaysCount(DateTime startDate, DateTime endDate) {
  //   List<DateTime> daysCount = [];
  //   DateTime currentDay = startDate;

  //   while (
  //       currentDay.isBefore(endDate) || currentDay.isAtSameMomentAs(endDate)) {
  //     daysCount.add(currentDay);
  //     currentDay = currentDay.add(const Duration(days: 1));
  //   }

  //   return daysCount;
  // }

  // Widget tabContainer({
  //   required BuildContext,
  //   required String day,
  //   required int index,
  //   required DateTime date,
  // }) {
  //   return InkWell(
  //     borderRadius: BorderRadius.circular(10),
  //     onTap: () {
  //       setState(() {
  //         selectTab = index;
  //       });
  //     },
  //     child: animatedContainerWidget(
  //         selectTab: selectTab,
  //         index: index,
  //         context: context,
  //         day: day,
  //         date: date),
  //   );
  // }

  // void updateTripActivities(Map<String, List<String>> updatedActivities) {
  //   setState(() {
  //     widget.trip.iteneraries = updatedActivities;
  //   });
  // }
}
