import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:wanderlust/models/trip.dart';

ValueNotifier<List<Budget>> budgetNotifier = ValueNotifier([]);

class BudgetService {
  Box<Budget>? _budgetBox;

  Future<void> openBox() async {
    await ensureBoxOpen();
  }

  Future<void> ensureBoxOpen() async {
    if (_budgetBox == null || !_budgetBox!.isOpen) {
      _budgetBox = await Hive.openBox('BudgetBox');
    }
  }

  Future<void> closeBox() async {
    await _budgetBox?.close();
  }

  Future<void> addBudget(Budget budget) async {
    await ensureBoxOpen();
    try {
      await _budgetBox!.put(budget.id, budget);
    } catch (e) {
      log('Error occured while adding budget $e');
    }
  }

  Future<List<Budget>> getBudgetsByTripId(String tripId) async {
    await ensureBoxOpen();

    return _budgetBox!.values
        .where((budget) => budget.tripId == tripId)
        .toList();
  }

  void refreshBudgetList() {
    budgetNotifier.value = _budgetBox!.values.toList();
    budgetNotifier.notifyListeners();
  }
  
}
