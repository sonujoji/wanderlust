import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wanderlust/models/trip.dart';

ValueNotifier<List<Trip>> tripListNotifier = ValueNotifier<List<Trip>>([]);

class TripService {
  Box<Trip>? _tripBox;

  Future<void> openBox() async {
    _tripBox = await Hive.openBox('TripBox');
  }

  Future<void> closeBox() async {
    await _tripBox!.close();
  }

  Future<void> addTrip(Trip trip) async {
    if (_tripBox == null) {
      openBox();
    }
    final id = await _tripBox!.add(trip);
    trip.id = id;
    await _tripBox!.put(id, trip);
    tripListNotifier.value.add(trip);
  }

  Future<List<Trip>> getTripDetails() async {
    if (_tripBox == null) {
      await openBox();
    }
    final data = List<Trip>.from(_tripBox!.values);
    tripListNotifier.value = [...data];
    return _tripBox!.values.toList();
  }

  Future<void> updateTrip(int index, Trip trip) async {
    if (_tripBox == null) {
      await openBox();
    }

    await _tripBox!.putAt(index, trip);
  }

  Future<void> deleteTrip(int index) async {
    if (_tripBox == null) {
      await openBox();
    }
    await _tripBox!.deleteAt(index);
  }
}
