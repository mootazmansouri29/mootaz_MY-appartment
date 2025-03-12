import 'package:flutter/material.dart';
import '../models/maison.dart';
import '../services/maison_service.dart';

class MaisonViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<Maison> _maisons = [];

  List<Maison> get maisons => _maisons;

  // Fetch all maisons from the database
  Future<void> fetchMaisons() async {
    _maisons = await _databaseService.getMaisons();
    notifyListeners();
  }

  // Add a new maison to the database
  Future<void> addMaison(Maison maison) async {
    await _databaseService.insertMaison(maison);
    await fetchMaisons();
  }

  // Delete a maison from the database
  Future<void> deleteMaison(int id) async {
    await _databaseService.deleteMaison(id);
    await fetchMaisons();
  }

  // Update a maison in the database
  Future<void> updateMaison(Maison maison) async {
    await _databaseService.updateMaison(maison);
    await fetchMaisons();
  }
}
