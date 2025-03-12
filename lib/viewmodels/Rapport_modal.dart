import 'package:flutter/material.dart';
import '../models/rapport.dart';
import '../services/rapport_service.dart';

class RapportViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<Rapport> _rapports = [];

  List<Rapport> get rapports => _rapports;

  // Fetch all rapports from the database
  Future<void> fetchRapports() async {
    _rapports = await _databaseService.getRapports();
    notifyListeners();
  }

  // Add a new rapport to the database
  Future<void> addRapport(Rapport rapport) async {
    await _databaseService.insertRapport(rapport);
    await fetchRapports();
  }

  // Delete a rapport from the database
  Future<void> deleteRapport(int id) async {
    await _databaseService.deleteRapport(id);
    await fetchRapports();
  }

  // Update a rapport in the database
  Future<void> updateRapport(Rapport rapport) async {
    await _databaseService.updateRapport(rapport);
    await fetchRapports();
  }
}
