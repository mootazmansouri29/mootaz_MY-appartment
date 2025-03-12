import 'package:flutter/material.dart';
import '../models/panne.dart';
import '../services/panne_service.dart';

class PanneViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<Panne> _pannes = [];

  List<Panne> get pannes => _pannes;

  // Fetch all pannes from the database
  Future<void> fetchPannes() async {
    _pannes = await _databaseService.getPannes();
    notifyListeners();
  }

  // Add a new panne to the database
  Future<void> addPanne(Panne panne) async {
    await _databaseService.insertPanne(panne);
    await fetchPannes();
  }

  // Delete a panne from the database
  Future<void> deletePanne(int id) async {
    await _databaseService.deletePanne(id);
    await fetchPannes();
  }

  // Update a panne in the database
  Future<void> updatePanne(Panne panne) async {
    await _databaseService.updatePanne(panne);
    await fetchPannes();
  }
}
