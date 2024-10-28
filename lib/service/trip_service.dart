import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wanderlust/models/trip.dart';

ValueNotifier<List<Trip>> tripListNotifier = ValueNotifier<List<Trip>>([]);

class TripService {
  Box<Trip>? _tripBox;

  Future<void> ensureBoxOpen() async {
    if (_tripBox == null || !_tripBox!.isOpen) {
      _tripBox = await Hive.openBox('TripBox');
    }
  }

  Future<void> openBox() async {
    await ensureBoxOpen();
  }

  Future<void> closeBox() async {
    await _tripBox!.close();
  }

  Future<void> addTrip(Trip trip) async {
    await ensureBoxOpen();
    final id = await _tripBox!.add(trip);
    trip.id = id;
    log('Trip id is ............. ${trip.id}');
    await _tripBox!.put(id, trip);
    tripListNotifier.notifyListeners();
    tripListNotifier.value.add(trip);
  }

  Future<List<Trip>> getTripDetails() async {
    await ensureBoxOpen();
    final data = List<Trip>.from(_tripBox!.values);
    tripListNotifier.value = [...data];
    return _tripBox!.values.toList();
  }

  Future<void> updateTrip(int index, Trip trip) async {
    await ensureBoxOpen();

    await _tripBox!.putAt(index, trip);
  }

  Future<void> deleteTrip(int index) async {
    await ensureBoxOpen();
    await _tripBox!.deleteAt(index);
  }
}
