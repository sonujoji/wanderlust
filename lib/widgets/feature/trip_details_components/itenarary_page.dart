import 'package:flutter/material.dart';
import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/service/trip_service.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/feature/show_dialogues/itenaray_dialogue.dart';
import 'package:wanderlust/widgets/feature/trip_details_components/animated_container.dart';
import 'package:wanderlust/widgets/global/custom_floating_button.dart';

class ItenararyPage extends StatefulWidget {
  final Trip trip;
  const ItenararyPage({super.key, required this.trip});

  @override
  State<ItenararyPage> createState() => _ItenararyPageState();
}

class _ItenararyPageState extends State<ItenararyPage> {
  int selectTab = 0;
  @override
  Widget build(BuildContext context) {
    TripService _tripService = TripService();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    List<DateTime> days =
        getDaysCount(widget.trip.startDate, widget.trip.endDate);
    final Trip trip = widget.trip;
   Map<String, List<String>>? iteneraries = trip.iteneraries;
    return ValueListenableBuilder(
      valueListenable: tripListNotifier,
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: primaryColor,
          body: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < days.length; i++)
                        tabContainer(
                          BuildContext: context,
                          day: "Day ${i + 1}",
                          index: i,
                          date: days[i],
                        )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: (iteneraries != null && 
                          iteneraries["Day ${selectTab + 1}"] != null)
                      ? iteneraries["Day ${selectTab + 1}"]!.length
                      : 0,
                  itemBuilder: (BuildContext context, int index) {
                    List<String>? plans = iteneraries!["Day ${selectTab + 1}"];
                    return Card(
                      child: ListTile(
                        leading: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.07,
                          decoration: BoxDecoration(
                              color: white, shape: BoxShape.circle),
                          child: Center(
                            child: Text("${index + 1}"),
                          ),
                        ),
                        title: Text(plans![index]),
                        trailing: IconButton(
                            onPressed: () async {
                              setState(() {
                                iteneraries["Day ${selectTab + 1}"]
                                    ?.remove(plans[index]);
                              });
                              await _tripService.updateTrip(index, trip);
                            },
                            icon: Icon(Icons.remove_circle)),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          floatingActionButton: CustomFloatingButton(
            onPressed: () {
              ItenarayDialogue(
                  context: context,
                  addItenerary: (newPlan) {
                    setState(() {
                      iteneraries!["Day ${selectTab + 1}"]?.add(newPlan);
                    });
                  }
                  ).addItenerairesDialogue();
            },
            icon: Icons.edit,
          ),
        );
      },
    );
  }

  List<DateTime> getDaysCount(DateTime startDate, DateTime endDate) {
    List<DateTime> daysCount = [];
    DateTime currentDay = startDate;

    while (
        currentDay.isBefore(endDate) || currentDay.isAtSameMomentAs(endDate)) {
      daysCount.add(currentDay);
      currentDay = currentDay.add(const Duration(days: 1));
    }

    return daysCount;
  }

  Widget tabContainer({
    required BuildContext,
    required String day,
    required int index,
    required DateTime date,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        setState(() {
          selectTab = index;
        });
      },
      child: animatedContainerWidget(
          selectTab: selectTab,
          index: index,
          context: context,
          day: day,
          date: date),
    );
  }
}
