import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/widgets/global/custom_text.dart';

class CompletedTripsTile extends StatefulWidget {
  final Trip trip;
  final int index;
  const CompletedTripsTile(
      {super.key, required this.trip, required this.index});

  @override
  State<CompletedTripsTile> createState() => _CompletedTripsTileState();
}

class _CompletedTripsTileState extends State<CompletedTripsTile> {
  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('MMM-dd-yyyy');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 180,
              width: double.infinity,
              child: Image.file(
                fit: BoxFit.cover,
                File(widget.trip.destinationImage),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text:
                                    '${widget.trip.title}, ${widget.trip.country}',
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                text:
                                    'Completed on: ${dateFormat.format(widget.trip.endDate)}',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Icon(
                            Icons.outbond,
                            color: Colors.white70,
                            size: 40,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
