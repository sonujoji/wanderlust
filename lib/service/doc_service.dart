import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wanderlust/models/trip.dart';

ValueNotifier<List<Documents>> documentsListNotifier = ValueNotifier([]);

class DocService {
  Box<Documents>? _docBox;

  Future<void> openBox() async {
    await ensureBoxOpen();
  }

  Future<void> ensureBoxOpen() async {
    if (_docBox == null || _docBox!.isOpen) {
      _docBox = await Hive.openBox('DocBox');
    }
  }

  Future<void> closeBox() async {
    await _docBox?.close();
  }

  Future<void> addDocuments(Documents documents) async {
    await ensureBoxOpen();
    try {
      await _docBox!.put(documents.id, documents);
      refreshDocumentList();
    } catch (e) {
      log('Error adding document $e');
    }
  }

  Future<List<Documents>> getDocsByTripid(String tripId) async {
    await ensureBoxOpen();
    try {
      final docs =
          _docBox!.values.where((doc) => doc.tripId == tripId).toList();
      documentsListNotifier.value = docs;
      return docs;
    } catch (e) {
      log('Erorr while getting docsbytripId $e');
    }
    return [];
  }

  Future<void> updateDocument(String id, Documents updatedDocument) async {
    await ensureBoxOpen();
    try {
      _docBox!.put(id, updatedDocument);
      refreshDocumentList();
    } catch (e) {
      log('Error while updating documents $e');
    }
  }

  Future<void> deleteDocument(String id) async {
    await ensureBoxOpen();
    try {
      _docBox!.delete(id);
      refreshDocumentList();
    } catch (e) {
      log('Error while deleting the document $e');
    } 
  }

  void refreshDocumentList() {
    documentsListNotifier.value = _docBox!.values.toList();
    documentsListNotifier.notifyListeners();
  }



}
