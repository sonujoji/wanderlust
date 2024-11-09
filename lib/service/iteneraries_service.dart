// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:wanderlust/models/trip.dart';

// ValueNotifier<List<Iteneraries>> itemsListNotifier = ValueNotifier([]);

// class ItinerariesService {
//   Box<Iteneraries>? _itemBox;

//   Future<void> openBox() async {
//     await ensureBoxOpen();
//   }

//   Future<void> ensureBoxOpen() async {
//     if (_itemBox == null || !_itemBox!.isOpen) {
//       _itemBox = await Hive.openBox<Iteneraries>('itinerariesBox');
//     }
//   }

//   Future<void> closeBox() async {
//     await _itemBox?.close();
//   }

//   Future<List<Iteneraries>> getAllItineraries() async {
//     await openBox();
//     final data =  _itemBox?.values.toList() ?? [];
//     return data;
//   }

//   Future<void> updateItineraries(
//       String id, Iteneraries updatedItinerary) async {
//     await openBox();
//     try {
//       await _itemBox?.put(id, updatedItinerary);

//       itemsListNotifier.value = await getAllItineraries();
//     } catch (e) {
//       print('Error updating itinerary: $e');
//     }
//   }

//   Future<void> deleteItineraries(String id) async {
//     await openBox();
//     try {
//       await _itemBox?.delete(id);

//       itemsListNotifier.value = await getAllItineraries();
//     } catch (e) {
//       print('Error deleting itinerary: $e');
//     }
//   }
// }
