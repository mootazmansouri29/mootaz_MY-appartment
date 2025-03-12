import 'package:flutter/material.dart';
import '../models/avis.dart';
import '../services/avis_service.dart';

class AvisViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<Avis> _avis = [];

  List<Avis> get avis => _avis;

  // Fetch all avis from the database
  Future<void> fetchAvis() async {
    _avis = await _databaseService.getAvis();
    notifyListeners();
  }

  // Add a new avis to the database
  Future<void> addAvis(Avis avis) async {
    await _databaseService.insertAvis(avis);
    await fetchAvis();
  }

  // Delete an avis from the database
  Future<void> deleteAvis(int id) async {
    await _databaseService.deleteAvis(id);
    await fetchAvis();
  }

  // Update an avis in the database
  Future<void> updateAvis(Avis avis) async {
    await _databaseService.updateAvis(avis);
    await fetchAvis();
  }
}
