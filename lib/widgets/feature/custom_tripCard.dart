//  Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: trips.isEmpty
//                     ? const Center(
//                         child: Text(
//                           'No trips available',
//                           style: TextStyle(color: Colors.white, fontSize: 18),
//                         ),
//                       )
//                     : ListView.builder(
//                         itemCount: trips.length,
//                         itemBuilder: (context, index) {
//                           final trip = trips[index];

//                           return Card(
//                             color: Colors.grey.shade300,
//                             margin: const EdgeInsets.symmetric(vertical: 10),
//                             child: Padding(
//                               padding: const EdgeInsets.all(15),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Place: ${trip.title}',
//                                     style: const TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     'Trip start date: ${DateFormat('dd-MM-yyyy').format(trip.startDate)}',
//                                     style: const TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     'Trip end date: ${DateFormat('dd-MM-yyyy').format(trip.endDate)}',
//                                     style: const TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     'Budget: ${trip.budget.toString()}',
//                                     style: const TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     'No of Travellors: ${trip.travellorCount}',
//                                     style: const TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ))

import 'package:flutter/material.dart';
import 'package:wanderlust/utils/colors.dart';

class CustomTripcard extends StatelessWidget {
  

  const CustomTripcard({ super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 64, 66, 86),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              'assets/images/pexels-pixabay-237272.jpg',
              fit: BoxFit.cover,
              height: 180,
              width: double.infinity,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '📍Munnar, Kerala',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '💸 ₹5000 ',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ' 📅 23/07/2024 - 26-07/2024',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '👥 1 ',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Text(
                  ' 🗺️ Munnar is a very nice place',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
