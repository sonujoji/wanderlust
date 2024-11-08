import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wanderlust/models/trip.dart';

ValueNotifier<List<Memories>> memoriesListNotifier = ValueNotifier([]);

class MemoriesService {
  Box<Memories>? _memBox;

  Future<void> openBox() async {
    await ensureBoxOpen();
  }

  Future<void> ensureBoxOpen() async {
    if (_memBox == null || _memBox!.isOpen) {
      _memBox = await Hive.openBox('MemBox');
    }
  }

  Future<void> closeBox() async {
    await _memBox?.close();
  }

  Future<void> addMemories(Memories memories) async {
    await ensureBoxOpen();
    try {
      await _memBox!.put(memories.id, memories);
      refreshMemoriesList();
    } catch (e) {
      log('Error adding memories $e');
    }
  }

  Future<List<Memories>> getMemoriesById(String tripId) async {
    await ensureBoxOpen();
    try {
      final memories =
          _memBox!.values.where((mem) => mem.tripId == tripId).toList();
      memoriesListNotifier.value = memories;
      return memories;
    } catch (e) {
      log('Error while fetching memoriesbytripid $e');
    }
    return [];
  }

  Future<void> deleteMemories(String id) async {
    await ensureBoxOpen();
    try {
      _memBox!.delete(id);
      refreshMemoriesList();
    } catch (e) {
      log('Error while deleting the document $e');
    }
  }

  void refreshMemoriesList() {
    memoriesListNotifier.value = _memBox!.values.toList();
    memoriesListNotifier.notifyListeners();
  }
}
